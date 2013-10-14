class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges do |t|
      t.string :name
      t.string :title
      t.string :organization
      t.string :sector
      t.belongs_to :user
      t.timestamps
    end
  end
end
