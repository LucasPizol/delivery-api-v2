class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :name, null: false
      t.string :document, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
