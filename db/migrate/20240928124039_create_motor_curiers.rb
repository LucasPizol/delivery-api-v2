class CreateMotorCuriers < ActiveRecord::Migration[7.2]
  def change
    create_table :motor_curiers, id: :uuid do |t|
      t.string :name, null: false
      t.string :lat, default: 0
      t.string :lng, default: 0
      t.string :code, null: false

      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
