class AddUserReferenceToBusiness < ActiveRecord::Migration[5.1]
  def change
    add_reference :businesses, :user, foreign_key: true
  end
end
