class ContributionsController < ApplicationController
  def index
    @contributions = current_user.contributions
    @contribtuion_total = current_user.contributions.map {|contribution| contribution.amount.to_i/100}.reduce(:+)
  end

  def show
    @contribution = current_user.contributions.find(params[:id])
  end

  def update
    @contribution = cart.contributions.find(params[:contribution][:id])
    @contribution.update(amount: params[:contribution][:amount].to_i * 100)
    redirect_to cart_path
  end

  def review
    redirect_to login_path if current_user.nil?
    @contributions = cart.contributions
  end

  def checkout
    @contributions = cart.contributions
    @contributions.each_with_index do |contribution, i|
      amount = Contribution.find(params[:contribution_ids][i].to_i).amount.to_i
      loan = contribution.loan
      if amount <= loan.pending
        contribution.update(amount: amount, user_id: current_user.id).update_to_paid  

      end
    end
    session[:cart_id] = nil
    redirect_to root_path
  end

  def cancel
    contribution = current_user.contributions.find(params[:contribution_id])
    contribution.update_to_cancelled
    redirect_to :back
  end
end
