class CreateLibraryTable < ActiveRecord::Migration[6.1]
  def change
    create_table :branches do |t|
      t.string :branch_name
      t.string :address
      t.integer :phone_number

      t.timestamps
    end
  end
end
