class LoansController < ApplicationController
	def show
    @loan = Loan.find(params[:id]).decorate
	end

	def index
		set_newest_loans
		@categories = Category.all.decorate
		@q = Loan.search(params[:q])
		if params[:q]
			@loans = @q.result.includes(:categories).all
		else
		  @loans = Loan.includes(:categories).all
	  end

		# group by category
		@loans_by_category = {}

		loan_requests.each do |loan|
			loan.categories.each do |category|
				@loans_by_category[category.name] ||= []
				@loans_by_category[category.name] << loan
			end
		end
	end

	private

	def loans
		@loans = Loan.all
	end

	def loan_requests
		Loan.request.decorate
	end

	def set_newest_loans
		# newest_category = Category.find_by(name: "Newest")
		# newest_loans = Loan.last(5)
		# newest_loans.map do |loan|
		# 	LoanCategory.create(loan_id: loan.id, category_id: newest_category.id)
		# end
	end
end
