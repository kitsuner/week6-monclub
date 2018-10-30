class AddColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :age, :integer
    add_column :users, :description, :text

    add_column :cities, :city_name, :string
    add_column :cities, :postal_code, :string

    add_column :gossips, :title, :string
    add_column :gossips, :content, :text
    add_column :gossips, :date, :timestamp

    add_column :tags, :title, :string

    add_column :comments, :content, :text

    add_column :privatemessages, :content, :text
    add_column :privatemessages, :date, :timestamp
  end
end
