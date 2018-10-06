class CreateHours < ActiveRecord::Migration[5.1]
  def change
    create_table :hours do |t|
      t.datetime :starts
      t.datetime :ends
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
