class CreateJoinTableBusinessLocation < ActiveRecord::Migration[5.1]
  def change
    create_join_table :businesses, :locations do |t|
      t.index [:business_id, :location_id]
      t.index [:location_id, :business_id]
    end
  end
end
