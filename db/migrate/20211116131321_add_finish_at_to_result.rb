class AddFinishAtToResult < ActiveRecord::Migration[6.0]
  def change
    add_column :results, :finish_at, :datetime
  end
end
