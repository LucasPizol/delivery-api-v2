class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :id
      t.string :email
      t.string :name
      t.string :document
      t.string :phone
      t.string :password
      t.datetime :createdAt
      t.datetime :updatedAt

      t.timestamps
    end
  end
end
