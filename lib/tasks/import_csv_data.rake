namespace :import do
  task csv_data: :environment do
    csv_data_paths = {
      inventory: 'db/csv_data/inventory.csv',
      product_prices: 'db/csv_data/product_prices.csv',
      accessory_compatability: 'db/csv_data/accessory_compatability.csv',
      purchase_orders: 'db/csv_data/purchase_orders.csv'
    }

    importer = CsvDataImporter.new(csv_data_paths)
    importer.process_inventory_import(:inventory)
    importer.process_inventory_import(:product_prices)
  end
end
