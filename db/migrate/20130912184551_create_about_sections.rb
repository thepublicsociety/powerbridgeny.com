class CreateAboutSections < ActiveRecord::Migration
  def change
    create_table :about_sections do |t|
      t.string :title
      t.text :content
      t.string :section
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
