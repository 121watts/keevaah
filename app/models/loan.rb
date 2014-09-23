class Loan < ActiveRecord::Base
	validates :title,
						:description,
						:amount,
						:requested_by,
						:repayments_begin,
						:monthly_payment,
						presence: true
	validates_numericality_of :amount,
	 													:monthly_payment,
														greater_than_or_equal_to: 0
	has_many :loan_categories
	has_many :categories, through: :loan_categories
	has_many :cart_loans
	has_many :carts, through: :cart_loan
	has_many :contributions
	belongs_to :user

	has_attached_file :image,
										styles: {:medium => "340x340>", :small => "150x150>", :thumb => "100x100>"},
										default_url: "/assets/images/happy-borrower.jpg",
										storage: :s3,
                   	s3_credentials: { :access_key_id => ENV['S3_KEY'],
															  			:secret_access_key => ENV['S3_SECRET']},
										bucket: ENV['AWS_BUCKET']
	validates_attachment :image, content_type: {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}

	include AASM

	aasm do
    state :request, initial: true
    state :fulfilled
    state :repayment
    state :repaid

    event :fulfill do
      transitions from: :request, to: :fulfilled
    end

    event :start_repay do
      transitions from: :fulfilled, to: :repayment
    end

    event :pay_off do
      transitions from: :repayment, to: :repaid
    end
  end

	def fulfilled?
		self.aasm_state = "fulfilled"
	end

	def contributed
		self.contributions.inject(0) { |i, contribution| i += contribution.amount.to_i }
	end

	def pending
		if (self.amount - self.contributed == 0)
			fulfill! if may_fulfill?
			self.amount - self.contributed
		else
			self.amount - self.contributed
		end
	end

	def progress
		((self.contributed.to_f / self.amount.to_f) * 100).to_i
	end

	def contribution_from(current_user)
		# self.contributed.where(user_id: current_user.id)
	end

	def remove_category(category_id)
    update_attribute(:categories, reject_from_categories(category_id))
	end

	def amount_in_dollars
		correct_decimal = amount / 100
		"$#{correct_decimal}"
	end

	def monthly_payment_in_dollars
		correct_decimal = monthly_payment / 100
		"$#{correct_decimal}"
	end

  private

  def reject_from_categories(category_id)
	  categories.reject { |category| category.id == category_id.to_i}
  end
end
