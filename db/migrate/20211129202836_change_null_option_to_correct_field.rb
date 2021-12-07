class ChangeNullOptionToCorrectField < ActiveRecord::Migration[6.0]
  def change
    change_column_null :answers, :correct, true
  end
end
