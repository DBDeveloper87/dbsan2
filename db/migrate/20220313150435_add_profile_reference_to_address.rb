class AddProfileReferenceToAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :profile, null: false, foreign_key: true, type: :uuid
  end
end
