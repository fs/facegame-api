class AddDiscardedAtToQuestions < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_column :questions, :discarded_at, :datetime
    add_index :questions, :discarded_at, algorithm: :concurrently
  end
end
