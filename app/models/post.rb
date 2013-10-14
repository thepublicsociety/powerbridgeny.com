class Post < ActiveRecord::Base
  attr_accessible :active, :content, :section, :title
end
