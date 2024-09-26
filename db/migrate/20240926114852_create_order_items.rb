class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :order_items, id: :uuid do |t|
      t.float :quantity, null: false
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.float :price, null: false
      t.references :order, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
