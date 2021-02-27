class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false
      t.references :issue, null: false
      t.boolean :agree, null: false, default: true
      t.timestamps
    end

    add_index :votes, %i[user_id issue_id], unique: true
  end
end
