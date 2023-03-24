class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :description
      t.integer :lowest_allowable_bid
      t.integer :starting_bid_price
      t.datetime :bidding_expiration
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
