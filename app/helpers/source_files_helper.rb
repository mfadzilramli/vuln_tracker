module SourceFilesHelper
  # def self.write_to_db(nessus_data)
  #   doc = Nokogiri::XML(nessus_data)
  #   doc.xpath('/NessusClientData_v2/Report').each do |report|
  #     report.xpath('./ReportHost').each do |host|
  #       @hosts = AffectedHost.new
  #       host.xpath('./HostProperties/tag').each do |tag|
  #         if tag.attributes['name'].value == 'host-ip'
  #           @hosts.host_ip = tag.text
  #         elsif tag.attributes['name'].value == 'host-fqdn'
  #           @hosts.host_fqdn = tag.text
  #         elsif tag.attributes['name'].value == 'netbios-name'
  #           @hosts.netbios_name = tag.text
  #         elsif tag.attributes['name'].value == 'mac-address'
  #           @hosts.mac_address = tag.text
  #         elsif tag.attributes['name'].value == 'operating-system'
  #           @hosts.os = tag.text
  #         elsif tag.attributes['name'].value == 'HOST_START'
  #           @hosts.scan_start = Time.parse(tag.text).strftime("%Y-%m-%d %I:%M:%S")
  #         elsif tag.attributes['name'].value == 'HOST_END'
  #           @hosts.scan_end = Time.parse(tag.text).strftime("%Y-%m-%d %I:%M:%S")
  #         end
  #       end
  #       @hosts.upload_id = this.id
  #       @hosts.save
  #     end
  #   end
  # end
end
