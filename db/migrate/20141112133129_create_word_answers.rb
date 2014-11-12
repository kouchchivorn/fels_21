class CreateWordAnswers < ActiveRecord::Migration
  def change
    create_table :word_answers do |t|
      t.string :content
      t.integer :word_id
      t.boolean :correct

      t.timestamps null: false
    end
  end
end
