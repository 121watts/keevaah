class CreateCartContribution < ActiveRecord::Migration
  def change
    create_table :cart_contribution do |t|
      t.integer :contribution_id
      t.integer :cart_id

      t.timestamps
    end
  end
end
