class Cart < ActiveRecord::Base
  has_many :loans, through: :cart_loans

  
end
