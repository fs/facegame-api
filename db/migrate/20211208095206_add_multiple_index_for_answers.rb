class AddMultipleIndexForAnswers < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  
  def change
    add_index :answers, [:question_id, :created_at], algorithm: :concurrently
  end
end
