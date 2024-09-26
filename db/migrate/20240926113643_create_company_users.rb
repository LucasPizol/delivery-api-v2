class CreateCompanyUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :company_users, id: :uuid do |t|
      t.string :role, null: false

      t.belongs_to :company, type: :uuid, index: true
      t.foreign_key :companies, column: :company_id, type: :uuid

      t.belongs_to :user, type: :uuid, index: true
      t.foreign_key :users, column: :user_id, type: :uuid

      t.timestamps
    end
  end
end
