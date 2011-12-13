class AddTimeZoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string, :default => 'Mountain Time (US & Canada)'
  end
end

