class AddsStatusColumnToContributions < ActiveRecord::Migration
  def self.up
    add_column :contributions, :status, :string
  end

  def self.down
    add_column :contributions, :status
  end
end
