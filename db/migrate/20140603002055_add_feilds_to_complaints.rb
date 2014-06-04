class AddFeildsToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :onset, :datetime
    add_column :complaints, :complaint_type, :string
  end
end
