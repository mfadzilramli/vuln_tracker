class CreateAffectedHost < ActiveRecord::Migration[5.0]
  def change
    create_table :affected_hosts do |t|
      t.ip_address  :host_ip
      t.string      :host_fqdn
      t.string      :netbios_name
      t.mac_address :mac_address
      t.string      :platform
      t.string      :operating_system
      # t.datetime  :scan_start
      # t.datetime  :scan_end

      t.timestamps
    end
  end
end
