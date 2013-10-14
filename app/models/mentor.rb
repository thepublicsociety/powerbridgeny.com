class Mentor < ActiveRecord::Base
  attr_accessible :name, :organization, :sector, :title, :user_id
  belongs_to :user
end
