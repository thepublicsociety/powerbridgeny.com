class AddColNumberToAboutSections < ActiveRecord::Migration
  def change
    add_column :about_sections, :col_number, :string
  end
end
