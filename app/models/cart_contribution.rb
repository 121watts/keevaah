class CartContribution < ActiveRecord::Base
  belongs_to :cart
  belongs_to :contribution
end
