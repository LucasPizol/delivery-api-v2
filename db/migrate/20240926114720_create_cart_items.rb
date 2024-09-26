class CreateCartItems < ActiveRecord::Migration[7.2]
  def change
    create_table :cart_items, id: :uuid do |t|
      t.float :quantity, null: false
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.references :customer, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
