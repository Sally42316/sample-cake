class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :name, null: false
      t.string :post_code, null: false
      t.text :address, null: false
      t.integer :customer_id, null: false
      t.timestamps
    end
  end
end
