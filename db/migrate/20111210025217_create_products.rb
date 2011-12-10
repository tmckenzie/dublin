class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :supplier
      t.string :sku

      t.timestamps
    end
  end
end
