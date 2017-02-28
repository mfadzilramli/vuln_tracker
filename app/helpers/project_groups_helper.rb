module ProjectGroupsHelper
  def get_score_card(affected_hosts)
    # Vulnerability.where(affected_host_id: h).joins(:remedy_action).where('status != 3').pluck(:cvss_score).map(&:to_f).sum
    # cvss_count  = affected_hosts.joins(:vulnerabilities).pluck(:cvss_score).map(&:to_f).sum
    cvss_count = Vulnerability.where(affected_host_id: affected_hosts).joins(:remedy_action).where('status != 3').pluck(:cvss_score).map(&:to_f).sum
    vuln_count = affected_hosts.joins(:vulnerabilities).count
    # hosts_count = affected_hosts.count
    if vuln_count != 0
      return (cvss_count/vuln_count).round(1)
    else
      return 0
    end
  end

  def get_top_vulns_critical(affected_hosts)
    #Vulnerability.where(affected_host_id: h, severity: 4).joins(:remedy_action).where('status != 3').group(:vulnerability_name).order('count_all DESC').limit(5).
    #top_vulns = affected_hosts.joins(:vulnerabilities).where('severity == 4').group(:vulnerability_name).order('count_all DESC').limit(5).count
    top_vulns = Vulnerability.where(affected_host_id: affected_hosts, severity: 4).joins(:remedy_action).where('status != 3').group(:vulnerability_name).order('count_all DESC').limit(5).count
    return top_vulns
  end

  def get_top_hosts_critical(affected_hosts)
    #top_hosts = affected_hosts.joins(:vulnerabilities).where('severity == 4').group(:host_ip).order('count_all DESC').limit(5).count
    top_hosts = Vulnerability.where(affected_host_id: affected_hosts, severity: 4).joins(:remedy_action,:affected_host).where('status != 3').group(:host_ip).order('count_all DESC').limit(5).count
    return top_hosts
  end

  def get_top_ports_critical(affected_hosts)
    #top_ports = affected_hosts.joins(:vulnerabilities).where('port != 0').group(:port).order('count_all DESC').limit(5).count
    top_ports = Vulnerability.where(affected_host_id: affected_hosts, severity: 4).where('port != 0').joins(:remedy_action).where('status != 3').group(:port).order('count_all DESC').limit(5).count
  end

  def get_affected_platforms(affected_hosts)
    affected_platforms = affected_hosts.group(:platform).count
    return affected_platforms
  end

  def get_low_hanging_fruits(affected_hosts)
    return Vulnerability.where(affected_host_id: affected_hosts).where('vulnerability_name LIKE ? or vulnerability_name LIKE ? or vulnerability_name LIKE ?',"%password%","%default credentials%", "%unauthenticated%").group(:vulnerability_name).count
  end

  def get_unsupported_systems(affected_hosts)
    return Vulnerability.where(affected_host_id: affected_hosts).where('vulnerability_name LIKE ?', "%unsupported%").group(:vulnerability_name).count
  end

end
