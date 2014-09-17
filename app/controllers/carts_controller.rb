class CartsController < ApplicationController
  def show
    @contributions = cart.contributions
  end

  def update
    add_contribution || delete_contribution
  end

  def destroy
    cart.destroy
    redirect_to root_path
  end

  private

  def add_contribution
    if current_user
      contribution = Contribution.create({loan_id: params[:cart][:loan_id], user_id: current_user.id})
    else
      contribution = Contribution.create({loan_id: params[:cart][:loan_id]})
    end
    cart.add_contribution(contribution) unless cart.contributions.include?(contribution)
    redirect_to cart
  end

  def delete_contribution
    contribution = Contribution.find(params[:cart][:contribution_id])
    cart.remove_contribution(contribution)
    redirect_to cart
  end
end
