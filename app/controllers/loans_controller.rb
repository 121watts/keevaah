class LoansController < ApplicationController
	def show
    @loan = Loan.find(params[:id]).decorate
	end

	def index
		@categories = Category.all.decorate
	  @loans = Loan.includes(:categories).all.decorate
		@loans_by_category = {}
		loan_requests.each do |loan|
			loan.categories.each do |category|
				@loans_by_category[category.name] ||= []
				@loans_by_category[category.name] << loan.decorate
			end
		end
		#group newest loans into newest category
		@newest_loans_by_category = {}
		newest_loans.each do |loan|
			newest_category = Category.find_by(name: "Newest")
			if newest_category
				LoanCategory.destroy_all(category_id: newest_category.id)
				loan.categories << newest_category
				@newest_loans_by_category[newest_category.name] ||= []
				@newest_loans_by_category[newest_category.name] << loan.decorate
			end
		end

		#all loans
	loan_requests.each do |loan|
			loan.decorate
		end
	end

	private

	def loan_requests
		Loan.request.sort_by {|loan| loan.progress}.reverse
	end

	def newest_loans
		newest_loans = Loan.request.order(created_at: :desc).limit(10)
	end
end
