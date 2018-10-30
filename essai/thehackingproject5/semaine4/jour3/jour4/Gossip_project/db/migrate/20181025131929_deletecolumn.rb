class Deletecolumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :privatemessages, :user_id, :integer
  end
end
