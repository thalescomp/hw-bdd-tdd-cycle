class AddDirectorField < ActiveRecord::Migration
  def up
    add_column :movies, :director, :string
  end
  
  def down
    remove_coluimn :movies, :director
  end
end
