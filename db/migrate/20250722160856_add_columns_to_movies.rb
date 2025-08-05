class AddColumnsToMovies < ActiveRecord::Migration[8.0]
  def change
    add_column :movies, :released_on, :date
    add_column :movies, :oscar_cohort, :integer
    add_column :movies, :result, :string, default: "nominated"
  end
end
