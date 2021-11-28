class CreateLibrariesBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :branches_books do |t|

      t.integer :branch_id
      t.integer :book_id

      t.timestamps
    end
  end
end
