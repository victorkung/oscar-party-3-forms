class CreateCredits < ActiveRecord::Migration[8.0]
  def change
    create_table :credits do |t|
      t.string :role
      t.integer :actor_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
