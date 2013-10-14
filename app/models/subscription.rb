class Subscription < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :group_name
end
