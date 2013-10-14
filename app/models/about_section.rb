class AboutSection < ActiveRecord::Base
  attr_accessible :active, :content, :section, :title, :logo
  has_attached_file :logo
end
