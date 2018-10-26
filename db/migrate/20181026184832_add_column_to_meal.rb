class AddColumnToMeal < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :out_price, :integer
    add_column :meals, :in_price, :integer
    add_column :meals, :user_id, :integer
  end
end
