class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
