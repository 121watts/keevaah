class Category < ActiveRecord::Base

	validates :name, presence: true, uniqueness: true
	has_many :loan_categories
	has_many :loans, through: :loan_categories

end
