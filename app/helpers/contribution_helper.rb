module ContributionHelper
  def total
    current_user.contributions.inject(0){|total, a| total += a.amount.to_i }
  end
end
