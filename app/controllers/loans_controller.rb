
class LoansController < ApplicationController
	def show
    @loan = Loan.find(params[:id]).decorate
	end
	
	def index
		@categories = Category.all.decorate
		@q = Loan.search(params[:q])
		if params[:q]
			@loans = @q.result.includes(:categories).all.decorate
		else
		  @loans = Loan.includes(:categories).all.decorate
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
		@loans = Loan.all.decorate
	end

	def loan_requests
		Loan.request.decorate
	end
end
