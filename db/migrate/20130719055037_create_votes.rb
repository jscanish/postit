class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.references :voteable, polymorphic: true
      t.integer :user_id
      #t.references == t.string :voteable_type and t.integer :voteable_id

      t.timestamps
    end
  end
end
