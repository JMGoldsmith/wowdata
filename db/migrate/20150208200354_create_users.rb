class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :realm
      t.string :password
      t.timestamp :createdDate
      t.timestamp :lastLogin
      t.timestamps null: false
    end
  end
end
