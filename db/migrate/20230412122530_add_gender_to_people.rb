class AddGenderToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :gender, :string
  end
end
