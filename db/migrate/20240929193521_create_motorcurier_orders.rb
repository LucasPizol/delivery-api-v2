class CreateMotorcurierOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :motorcurier_orders, id: :uuid do |t|
      t.references :order, null: false, foreign_key: true, type: :uuid
      t.references :motor_curier, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
