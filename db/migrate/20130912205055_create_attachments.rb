class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :note

      t.timestamps
    end
  end
end
