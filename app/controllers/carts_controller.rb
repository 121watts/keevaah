class CartsController < ApplicationController
  def show
  end

  def add_loan
    loan = Loan.find(params[:loan_id])
    cart.add_loan(loan)
    redirect_to cart
  end

  def delete_loan
    loan = Loan.find(params[:loan_id])
    cart.remove_loan(loan)
    redirect_to cart
  end

  def destroy
    cart.destroy
    redirect_to root_path
  end
end
