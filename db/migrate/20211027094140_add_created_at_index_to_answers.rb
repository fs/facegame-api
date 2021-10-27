class AddCreatedAtIndexToAnswers < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :answers, [:created_at, :question_id, :correct], algorithm: :concurrently
  end
end
