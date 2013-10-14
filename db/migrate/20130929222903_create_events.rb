class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :event_date
      t.string :event_name
      t.text :event_description

      t.timestamps
    end
  end
end
