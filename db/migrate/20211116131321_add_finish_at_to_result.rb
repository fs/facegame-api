class AddFinishAtToResult < ActiveRecord::Migration[6.0]
  def change
    add_column :results, :finished_at, :datetime, precision: 6, null: true
  end
end
