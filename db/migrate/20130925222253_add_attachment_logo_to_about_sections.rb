class AddAttachmentLogoToAboutSections < ActiveRecord::Migration
  def self.up
    change_table :about_sections do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :about_sections, :logo
  end
end
