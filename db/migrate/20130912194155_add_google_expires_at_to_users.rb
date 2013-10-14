class AddGoogleExpiresAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_expires_at, :datetime
  end
end
