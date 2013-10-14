class AddAttachmentAttachedFileToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :attached_file
    end
  end

  def self.down
    drop_attached_file :attachments, :attached_file
  end
end
