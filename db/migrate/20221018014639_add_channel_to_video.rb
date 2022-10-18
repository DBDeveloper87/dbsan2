class AddChannelToVideo < ActiveRecord::Migration[7.0]
  def change
    add_reference :videos, :channel, foreign_key: true, type: :uuid
  end
end
