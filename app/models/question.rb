class Question < ActiveRecord::Base
  attr_accessible :answered, :content, :title, :votes, :row_order, :row_order_position
  has_many :answers
  include RankedModel
  ranks :row_order
end
