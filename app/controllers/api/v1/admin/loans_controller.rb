class Api::V1::Admin::LoansController < ApplicationController
  respond_to :json
  def index
    loans = Loan.all
    respond_with loans
  end

  def show
    loan = Loan.find(params[:id])
    respond_with loan
  end

  def create
    if loan = Loan.create(loan_params)
      respond_with loan
    else
      raise ArgumentError.new("you suck, try again")
    end
  end

  private

  def loan_params
    params.require(:loan).permit(:title)
  end
end
