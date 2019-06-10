require 'csv'

class CsvDataImporter
  def initialize(csv_file_paths)
    @csv_file_paths = csv_file_paths
  end

  def inventory_import(file)
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

  def acc_compat_import(file)
    File.open(@csv_file_paths[file]) do |f|
      header_row = f.gets
      header_row_arr = header_row.split(',').each_with_index.map { |el, i| el = i > 0 && el.blank? ? header_row.split(',')[i - 1] : el }
      csv = CSV.new(f, headers: true)
      csv.to_a.each do |row|
        combined_header = header_row_arr.each_with_index.map { |el, i| el.downcase + ' ' + row.headers[i].to_s.downcase }
        header_values_hash = Hash[combined_header.zip(row.fields)]
        header_values_hash.each do |hvh|
          next unless hvh[1] == 'x'

          sa = StuffedAnimal.find_by('lower(description) = ?', header_values_hash.first.last.downcase)
          sa_variation = sa.item_variations.first
          acc = Accessory.find_by('lower(description) = ?', hvh.first.split(' ').last)
          size = Size.where('lower(name) = ?', hvh[0].split(' ').first.downcase).first_or_create
          acc_variation = ItemProduct.joins(:item)
                                     .find_by(product: acc)
                                     .item_variations.where(size: size).first
          acc_variation.compat_items << sa_variation unless acc_variation.compat_items.include? sa_variation
        end
      end
    end
  end

  def purchase_order_import(file)
    File.open(@csv_file_paths[file]) do |f|
      header_row = f.gets
      header_row_arr = header_row.gsub!('Stuffed Animal', '').split(',').each_with_index.map do |el, i|
        el = i > 0 && el.blank? ? header_row.split(',')[i - 1] : el
      end
      csv = CSV.new(f, headers: true)
      csv.to_a.each do |row|
        combined_header = header_row_arr.each_with_index.map do |el, i|
          (el.downcase + ' ' + row.headers[i].to_s.downcase).strip
        end
        header_values_hash = Hash[combined_header.zip(row.fields)]
        date_string = header_values_hash['date']
        time_string = header_values_hash['time']
        datetime_string = date_string + ' ' + time_string
        po_datetime = begin
                        DateTime.strptime(datetime_string, '%m/%d/%Y %H:%M:%S %p')
                      rescue StandardError
                        nil
                      end
        po = PurchaseOrder.create(order_datetime: po_datetime)
        header_values_hash.except('date', 'time').each do |hvh|
          next unless hvh[1].to_i > 0

          if hvh[0].split.count > 1
            model_inst = Accessory.find_by('lower(description) = ?', hvh[0].split.last)
            size = Size.where('lower(name) = ?', hvh[0].split(' ').first.downcase).first_or_create
          else
            model_inst = StuffedAnimal.find_by('lower(description) = ?', hvh[0])
            size = Size.find_by(name: 'All')
          end
          variation = ItemProduct.joins(:item)
                                 .find_by(product: model_inst)
                                 .item_variations.where(size: size).first_or_create
          poi = po.purchase_order_items.create(item_variation: variation)
          poi.quantity = hvh[1].to_i
          poi.save
        end
      end
      break
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
