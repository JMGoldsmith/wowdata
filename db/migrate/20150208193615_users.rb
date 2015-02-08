class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :realm
      t.string :password
      t.timestamp :createdDate
      t.timestamp :lastLogin
    end
  end
end
