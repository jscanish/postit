class CreatePostcategories < ActiveRecord::Migration
  def change
    create_table :postcategories do |t|
      t.integer :post_id
      t.integer :category_id
      t.timestamps
    end
  end
end
