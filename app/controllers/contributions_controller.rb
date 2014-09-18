class ContributionsController < ApplicationController
  def show
    current_user
  end

  def review
    @contributions = cart.contributions
    if current_user = nil
      redirect_to login_path
    end
  end

  def checkout
    @contributions = cart.contributions
    @contributions.each_with_index do |contribution, i|
      amount = params[:amounts][i].to_i * 100
      loan = contribution.loan
      binding.pry
      if amount <= loan.pending
        contribution.update={amount: amount, user_id: current_user.id, status: 'paid'}
        # don't do this
        if loan.pending == 0
          loan.fulfill!
        end
      end
    end
    session[:cart] = nil
    redirect_to root_path
  end
end
