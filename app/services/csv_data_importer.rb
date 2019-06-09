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
          process_inv_import_el(StuffedAnimal, row[0], 'All', row[1], nil, nil)
          process_inv_import_el(Accessory, row[3], row[4], row[5], nil, nil)
        elsif file == :product_prices
          process_inv_import_el(StuffedAnimal, row[0], 'All', nil, row[1], row[2])
          process_inv_import_el(Accessory, row[4], row[5], nil, row[6], row[7])
        end
      end
    end
  end

  private

  def process_inv_import_el(model, desc, size, qty, cost, sale_price)
    return if desc.blank?

    model.transaction do
      model_inst = model.where(description: desc).first_or_create
      model_inst_item = Item.joins(:item_product).where(item_products: { product: model_inst }).first
      if model_inst_item.blank?
        model_inst_item = Item.new
        model_inst_item.build_item_product(product: model.where(description: desc).first_or_create)
        model_inst_item.save
      end
      model_inst_size = Size.where(name: size).first_or_create
      model_inst_item.sizes << model_inst_size unless model_inst_item.sizes.include? model_inst_size
      model_inst_item_variation = model_inst_item.item_variations.where(size: model_inst_size).first_or_create
      if model_inst_item_variation.present?
        model_inst_item_variation.quantity = qty.to_i unless qty.blank?
        model_inst_item_variation.cost = cost.to_f unless cost.blank?
        model_inst_item_variation.sale_price = sale_price.to_f unless sale_price.blank?
        model_inst_item_variation.save
      end
    end
  end
end
