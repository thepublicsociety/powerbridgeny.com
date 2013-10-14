class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :name
      t.string :title
      t.text :body
      t.boolean :published, :default => true

      t.timestamps
    end
  end
end
