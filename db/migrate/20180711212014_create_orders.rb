class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :week_number
      t.decimal :total_price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
