class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.references :company, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.string :document, null: false
      t.string :phone, null: false
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
