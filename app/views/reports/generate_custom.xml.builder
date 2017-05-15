if @options == 'all'
  affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids)
else
  affected_hosts = AffectedHost.where(id: @project_group.affected_host_ids)
end

xml.instruct!
xml.NessusClientData_v2 do
  xml.Report(name: @project_group.name, 'xmlns:cm': 'http://www.nessus.org/cm') do
    # @project_group.affected_hosts.each do |host|
    # Vulnerability.where(affected_host_id: affected_host_ids).each do |host|
    affected_hosts.each do |host|
      xml.ReportHost(name: host.host_ip) do
        xml.HostProperties do
          xml.tag(host.platform, name: 'os')
          xml.tag(host.mac_address, name: 'mac-address')
          xml.tag(host.operating_system, name: 'operating-system')
          xml.tag(host.host_fqdn, name: 'host-fqdn')
          xml.tag(host.netbios_name, name: 'netbios-name')
          xml.tag(host.host_ip, name: "host-ip")
        end
        host.vulnerabilities.where(severity: @severity).each do |v|
          xml.ReportItem(port: v.port, svc_name: v.service_name, protocol: v.protocol, severity: v.severity,
            pluginID: v.plugin_id, pluginName: v.name, pluginFamily: v.plugin_family) do
              xml.cve v.cve
              xml.plugin_type v.plugin_type
              xml.risk_score v.cvss_score
              xml.synopsis v.synopsis
              xml.description v.description
              xml.solution v.solution
              xml.plugin_output v.output
          end
        end
      end
    end
  end
end
