class Answer < ActiveRecord::Base
  attr_accessible :accepted, :content, :question_id, :votes
  belongs_to :question, :foreign_key => "question_id"
end
