class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.float :price, null: false
      t.float :quantity
      t.string :image, null: false
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
