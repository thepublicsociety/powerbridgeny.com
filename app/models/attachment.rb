class Attachment < ActiveRecord::Base
  attr_accessible :note, :attached_file
  has_attached_file :attached_file
  
  def has_image
    %w(.png .jpg .jpeg .gif .bmp).include? File.extname(self.attached_file.path)
  end
end
