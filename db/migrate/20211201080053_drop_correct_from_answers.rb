class DropCorrectFromAnswers < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :answers, :correct, :boolean }
  end
end
