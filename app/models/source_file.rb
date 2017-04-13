class SourceFile < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_many  :affected_hosts, dependent: :destroy
  has_many :monitored_items, dependent: :destroy
  has_many :project_groups, through: :monitored_items

  def self.to_db(source)
    doc = Nokogiri::XML(source.data)
    doc.xpath('/NessusClientData_v2/Report').each do |report|
      report.xpath('./ReportHost').each do |host|
        @host = source.affected_hosts.new
        host.xpath('./HostProperties/tag').each do |tag|
          if tag.attributes['name'].value == 'host-ip'
            @host.host_ip = tag.text.strip
          elsif tag.attributes['name'].value == 'host-fqdn'
            @host.host_fqdn = tag.text.strip
          elsif tag.attributes['name'].value == 'netbios-name'
            @host.netbios_name = tag.text.strip
          elsif tag.attributes['name'].value == 'mac-address'
            @host.mac_address = tag.text.strip
          elsif tag.attributes['name'].value == 'operating-system'
            @host.operating_system = tag.text.strip
          elsif tag.attributes['name'].value == 'os'
            @host.platform = tag.text.strip
          elsif tag.attributes['name'].value == 'HOST_START'
            @last_seen = Time.parse(tag.text).strftime("%Y-%m-%d %I:%M:%S")
          end
        end

        @host.save
        host.xpath('./ReportItem').each do |item|
          if item.attributes['severity'].value.to_i > 0
            @vuln = @host.vulnerabilities.new
            @vuln.port = item.attributes['port'].value.to_i
            @vuln.service_name = item.attributes['svc_name'].value
            @vuln.protocol = item.attributes['protocol'].value
            @vuln.severity = item.attributes['severity'].value.to_i
            @vuln.plugin_id = item.attributes['pluginID'].value.to_i
            @vuln.vulnerability_name = item.attributes['pluginName'].value
            @vuln.plugin_family = item.attributes['pluginFamily'].value

            @vuln.cvss_score = item.xpath('./cvss_base_score').text
            # TODO : need to loop this element
            @vuln.cve = item.xpath('./cve').map(&:text).join(", ")
            @vuln.cpe = item.xpath('./cpe').text
            @vuln.synopsis = item.xpath('./synopsis').text
            @vuln.description = item.xpath('./description').text.strip
            @vuln.solution = item.xpath('./solution').text.strip
            @vuln.output = item.xpath('./plugin_output').text.strip
            @vuln.exploit_available = (item.xpath('./exploit_available').text == "true")? 'true' : 'false'
            @vuln.vulnerability_date = item.xpath('./vulnerability_publication_date').text
            @vuln.patch_date = item.xpath('./patch_publication_date').text
            @vuln.plugin_type = item.xpath('./plugin_type').text
            @vuln.last_seen = @last_seen

            @vuln.save
            # @remedy = @vuln.create_remedy_action!
          end
        end
      end
    end
  end

end
