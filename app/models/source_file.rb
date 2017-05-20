class SourceFile < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_many  :affected_hosts, dependent: :destroy
  has_many :monitored_items, dependent: :destroy
  has_many :project_groups, through: :monitored_items

  def self.to_db(source)
    doc = Nokogiri::XML(source.data)
    doc.xpath('/Solaris_v1/Report').each do |report|
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
            @vuln.name = item.attributes['pluginName'].value
            @vuln.plugin_family = item.attributes['pluginFamily'].value

            # TODO : need to loop this element
            @vuln.cve = item.xpath('./cve').map(&:text).join(",")
            @vuln.cwe = item.xpath('./cwe').map(&:text).join(",")
            @vuln.cpe = item.xpath('./cpe').text

            @vuln.plugin_name = item.xpath('./plugin_name').text
            @vuln.plugin_type = item.xpath('./plugin_type').text
            @vuln.cvss_score = item.xpath('./cvss_base_score').text

            @vuln.synopsis = item.xpath('./synopsis').text.strip
            @vuln.description = item.xpath('./description').text.strip
            @vuln.solution = item.xpath('./solution').text.strip
            @vuln.affected_url = item.xpath('./affected_url').text

            @vuln.request = item.xpath('./request').text
            @vuln.response = item.xpath('./response').text
            @vuln.parameter = item.xpath('./parameter').text

            @vuln.xref = item.xpath('./xref').map(&:text).join(",")

            @vuln.publish_date = item.xpath('./publish_date').text
            @vuln.patch_date = item.xpath('./patch_date').text

            @vuln.save
            # @remedy = @vuln.create_remedy_action!
          end
        end
      end
    end
  end

end
