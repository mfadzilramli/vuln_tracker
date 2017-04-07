class CreateAffectedHost < ActiveRecord::Migration[5.0]
  def change
    create_table :affected_hosts do |t|
      t.string      :host_ip
      t.string      :host_fqdn
      t.string      :netbios_name
      t.string       :mac_address
      t.string      :platform
      t.string      :operating_system
      t.timestamps
    end
  end
end
