class AddAdminToUsers < ActiveRecord::Migration

  def change
    add_column :users, :mmp_admin, :boolean, :default => false
  end

end
