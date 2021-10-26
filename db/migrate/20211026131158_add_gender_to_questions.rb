class AddGenderToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :gender, :string
  end
end
