class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :address
      t.string :lat
      t.string :lng
      t.references :company, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
