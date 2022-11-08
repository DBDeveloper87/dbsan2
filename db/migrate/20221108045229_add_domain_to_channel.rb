class AddDomainToChannel < ActiveRecord::Migration[7.0]
  def change
    add_column :channels, :domain_host, :string
  end
end
