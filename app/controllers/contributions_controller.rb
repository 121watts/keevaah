class ContributionsController < ApplicationController
  def show
    current_user
  end

  def update
    @contribution = Contribution.find(params[:contribution][:id])
    @contribution.update(amount: params[:contribution][:amount])
    redirect_to cart_path
  end

  def review
    redirect_to login_path if current_user.nil?
    @contributions = cart.contributions
  end

  def checkout
    @contributions = cart.contributions
    @contributions.each_with_index do |contribution, i|
      amount = params[:amounts][i].to_i * 100
      loan = contribution.loan
      if amount <= loan.pending
        contribution.update={amount: amount, user_id: current_user.id, status: 'paid'}
      end
    end
    session[:cart] = nil
    redirect_to root_path
  end
end
