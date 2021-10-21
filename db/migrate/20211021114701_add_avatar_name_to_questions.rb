class AddAvatarNameToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :avatar_name, :string
  end
end
