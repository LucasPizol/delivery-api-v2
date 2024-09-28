class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :status, null: false
      t.string :address, null: false
      t.string :lat, null: false
      t.string :lng, null: false
      t.string :payment_method, null: false
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
