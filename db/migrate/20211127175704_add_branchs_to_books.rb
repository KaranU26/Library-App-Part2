class AddBranchsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :branchname, :string
    add_column :books, :branchaddress, :string
    add_column :books, :branchnumber, :integer
  end
end
