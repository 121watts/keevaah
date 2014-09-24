class ContributionDecorator < Draper::Decorator
  delegate_all

  def contribution_range
    (2500..contribution.loan.pending).step(2500).map do |increment|
      [helpers.number_to_currency(increment/100), increment]    
    end
  end
end
