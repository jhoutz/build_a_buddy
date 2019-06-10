namespace :import do
  task csv_data: :environment do
    csv_data_paths = {
      inventory: 'db/csv_data/inventory.csv',
      product_prices: 'db/csv_data/product_prices.csv',
      accessory_compatability: 'db/csv_data/accessory_compatibility.csv',
      purchase_orders: 'db/csv_data/purchase_orders.csv'
    }

    importer = CsvDataImporter.new(csv_data_paths)
    importer.inventory_import(:inventory)
    importer.inventory_import(:product_prices)
    importer.acc_compat_import(:accessory_compatability)
    importer.purchase_order_import(:purchase_orders)
  end
end
