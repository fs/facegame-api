class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.string :department, null: false
      t.text :avatar_data

      t.timestamps
    end
  end
end
