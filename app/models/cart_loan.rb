class CartLoan < ActiveRecord::Base
  belongs_to :cart
  belongs_to :loan
end
