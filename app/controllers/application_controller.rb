class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_cart, :is_borrower?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_borrower?
    current_user && current_user.role == 'borrower'
  end

  def is_lender?
    current_user && current_user.role == 'lender'
  end

  def check_user
    unless current_user
      login_with_flash
    end
  end

  def check_lender
    unless is_lender?
      login_with_flash
    end
  end

  def check_borrower
    unless is_borrower?
      login_with_flash
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  helper_method def cart
    cart ||= (_create_cart || _session_cart)
  end

  helper_method def cart_count
    # @cart.contributions ? @cart.contributions.count : 0
    if cart.contributions.count
      cart.contributions.count
    else
      0
    end
  end

  private

  def login_with_flash
    flash[:success] = 'One more step to contribution to the loan(s) you have selected.'
    session[:last_page] = request.path
    redirect_to login_path
  end

  def _session_cart
    return unless session[:cart_id]
    current_cart ||= Cart.find(session[:cart_id])
  end

  def _create_cart
    return if session[:cart_id]
    current_cart = Cart.create!
    session[:cart_id] = current_cart.id
    current_cart
  end
end
