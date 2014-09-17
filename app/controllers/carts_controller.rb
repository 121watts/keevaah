class CartsController < ApplicationController
  def show
    @loans = cart.loans.decorate
  end

  def update
    add_loan || delete_loan
  end

  def destroy
    cart.destroy
    redirect_to root_path
  end

  private

  def add_loan
    loan = Loan.find(params[:cart][:loan_id])
    cart.add_loan(loan) unless cart.loans.include?(loan)
    redirect_to cart
  end

  def delete_loan
    loan = Loan.find(params[:cart][:loan_id])
    cart.remove_loan(loan)
    redirect_to cart
  end
end
