class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :supplier
      t.string :name

      t.timestamps
    end
  end
end
