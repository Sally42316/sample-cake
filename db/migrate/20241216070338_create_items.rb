class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :nontaxprice, null: false
      t.integer :genre_id, null: false
      t.boolean :is_sell_status, default: true, null: false
      t.timestamps
    end
  end
end
