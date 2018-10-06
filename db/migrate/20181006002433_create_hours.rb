class CreateHours < ActiveRecord::Migration[5.1]
  def change
    create_table :hours do |t|
      t.time :starts
      t.time :ends
      t.datetime :valid_date
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
