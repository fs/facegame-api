class AddStatusColumnToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :status, :string, null: false, default: :pending
  end
end
