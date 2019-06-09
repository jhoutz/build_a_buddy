require 'csv'

class CsvDataImporter
  def initialize(csv_file_paths)
    @csv_file_paths = csv_file_paths
  end

  def process_inventory_import(file)
    File.open(@csv_file_paths[file]) do |f|
      2.times { f.gets } # skip first row
      csv = CSV.new(f, headers: false)
      csv.to_a.each do |row|
        if file == :inventory
          process_inv_import_el(StuffedAnimal, row[0], 'all', row[1], nil, nil)
          process_inv_import_el(Accessory, row[3], row[4], row[5], nil, nil)
        elsif file == :product_prices
          process_inv_import_el(StuffedAnimal, row[0], 'all', nil, row[1], row[2])
          process_inv_import_el(Accessory, row[4], row[5], nil, row[6], row[7])
        end
      end
    end
  end

  private

  def process_inv_import_el(model, desc, size, qty, cost, sale_price)
    model.transaction do
      model_inst = model.where(description: desc).first_or_create
      model_inst_item = Item.joins(:item_product).where(item_products: { product: model_inst }).first
      if model_inst_item.blank?
        model_inst_item = Item.new
        model_inst_item.build_item_product(product: model.where(description: desc).first_or_create)
        model_inst_item.save
      end
      model_inst_size = model_inst_item.sizes.where(name: size).first_or_create
      model_inst_item_variation = model_inst_item.item_variations.find_by(size: model_inst_size)
      if model_inst_item_variation.present?
        model_inst_item_variation.update_attributes(
          quantity: qty.to_i,
          cost: cost.to_f,
          sale_price: sale_price.to_f
        )
      end
    end
  end
end
