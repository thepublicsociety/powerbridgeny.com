class AddGroupNameToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :group_name, :string
  end
end
