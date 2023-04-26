class AddChannelToSocialNetwork < ActiveRecord::Migration[7.0]
  def change
    add_reference :social_networks, :channel, foreign_key: true, type: :uuid
  end
end
