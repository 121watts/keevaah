class Borrower::LoansController < BorrowersController
	def dashboard
		@loan_states = Loan.aasm.states.map {|state| state.name.to_s }
		@loans_by_state = {}
		current_user.loans.each do |loan|
			@loans_by_state[loan.aasm_state] ||= []
			@loans_by_state[loan.aasm_state] << loan.decorate
		end
	end

	def show
    @loan = current_user.loans.find(params[:id]).decorate
	end

	def new
		@loan = Loan.new
	end

	def create
		@loan = current_user.loans.new(loan_params)
		if @loan.save
			@loan_category = LoanCategory.create(loan_id: @loan.id, category_id: params[:loan][:categories])
			redirect_to borrower_path
		else
			render :new
		end
	end

	def edit
    @loan = current_user.loans.find(params[:id]).decorate
    @categories = Category.all
	end

	def update
    @loan = current_user.loans.find(params[:id]).decorate
		if @loan.update(loan_params)
			@loan_category = LoanCategory.create(loan_id: @loan.id, category_id: params[:loan][:categories])
			redirect_to borrower_path
		else
			render :edit
		end
	end

	def delete_category
		loan = Loan.find(params[:loan_id])
		loan.remove_category(params[:category_id])
		redirect_to edit_borrower_loan_path(loan)
	end

	def destroy
		if current_user.loans.find_by(id: params[:id], aasm_state: "request")
			current_user.loans.find(params[:id]).destroy
			redirect_to borrower_path
		else
			redirect_to borrower_path, notice: "You cannot cancel a loan that has been fulfilled"
		end
	end

	def retire
		@loan = Loan.find(params[:loan_id])
		@loan.retire
		redirect_to borrower_path
	end

	private

	def loan_params
		safe_params = params.require(:loan).permit(:title, :description, :amount, :image, :repayments_begin, :requested_by, :monthly_payment)
    update_params(safe_params)
	end

	def update_params(columns)
    columns[:amount] = (columns[:amount].to_d * 100).to_i unless columns[:amount].empty?
		columns
	end
end
