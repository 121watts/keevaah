class LoansController < ApplicationController
	def show
    @loan = Loan.find(params[:id]).decorate
	end

	def index
    @loans = Loan.all.decorate
	end
end
