class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :usario, index: true, foreign_key: true
      t.references :friend, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
