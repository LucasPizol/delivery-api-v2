class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :status, null: false
      t.references :address, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.references :customer, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
