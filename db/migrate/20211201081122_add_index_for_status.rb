class AddIndexForStatus < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  
  def change
    add_index :answers, :status, algorithm: :concurrently
  end
end
