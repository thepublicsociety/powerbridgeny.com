class AddInFooterToEvents < ActiveRecord::Migration
  def change
    add_column :events, :in_footer, :boolean, :default => false
  end
end
