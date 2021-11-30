class AddDefaultOptionToStatus < ActiveRecord::Migration[6.0]
  def change
    change_column_default :answers, :status, "pending"
  end
end
