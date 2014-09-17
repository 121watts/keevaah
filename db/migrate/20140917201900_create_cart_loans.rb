class CreateCartLoans < ActiveRecord::Migration
  def change
    create_table :cart_loans do |t|
      t.integer :loan_id
      t.integer :cart_id

      t.timestamps
    end
  end
end
