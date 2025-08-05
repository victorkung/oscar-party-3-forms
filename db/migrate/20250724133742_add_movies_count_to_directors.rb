class AddMoviesCountToDirectors < ActiveRecord::Migration[8.0]
  def change
    add_column :directors, :movies_count, :integer
  end
end
