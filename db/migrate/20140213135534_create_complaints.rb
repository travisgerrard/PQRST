class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :provoke
      t.string :quality
      t.string :radiation
      t.integer :severity
      t.string :time
      t.string :note

      t.timestamps
    end
  end
end
