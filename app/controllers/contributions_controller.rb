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
      # validate contribution
      contribution.update(amount: params[:amounts][i], user_id: current_user.id, status: 'paid')
      # update loan
      session[:cart] = nil
    end
    redirect_to root_path
  end
end


{"utf8"=>"✓", "authenticity_token"=>"Kr+WWayjMRVb7sUk8XhXS2bnDufL434fCiYW97sgdqU=", "contribution_ids"=>["7", "8"], "amounts"=>["25", "25"], "stripe_card_token"=>"", "credit_card"=>"4242424242424242", "exp-month"=>"1", "exp-year"=>"15", "CVV"=>"123", "commit"=>"Checkout", "action"=>"checkout", "controller"=>"contributions"}
