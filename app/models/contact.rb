class Contact < ActiveRecord::Base
  attr_accessible :email, :name, :organization, :phone
end
