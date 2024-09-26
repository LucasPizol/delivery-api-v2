class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :street, null: false
      t.string :number, null: false
      t.string :complement
      t.string :district, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :zipcode, null: false
      t.references :company, foreign_key: true, type: :uuid
      t.references :customer, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
