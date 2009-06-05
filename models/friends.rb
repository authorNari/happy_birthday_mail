require 'sequel'
Sequel::Model.plugin(:schema)
 
Sequel.sqlite("friends.db")

class Friends < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      string :name
      string :mail_address
      string :subject
      text :message
      integer :birthmonth
      integer :birthday
      timestamp :updated_at
      timestamp :created_at
    end
    create_table
  end
end
