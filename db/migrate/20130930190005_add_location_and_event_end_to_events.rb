class AddLocationAndEventEndToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location, :string
    add_column :events, :event_end, :datetime
  end
end
