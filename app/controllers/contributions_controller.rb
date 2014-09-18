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
    @contributions.each do |contribution|
      # validate contribution
      contribution.update(amount: params[:amount], user_id: current_user.id, status: 'paid')
      # update loan
    end
  end
end
