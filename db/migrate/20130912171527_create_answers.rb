class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :question_id
      t.integer :votes, :default => 0
      t.boolean :accepted, :default => false

      t.timestamps
    end
  end
end
