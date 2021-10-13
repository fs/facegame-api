class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.references :result, foreign_key: true, null: false
      t.references :question, foreign_key: true, null: false
      t.string :value
      t.boolean :correct, null: false

      t.timestamps
    end
  end
end
