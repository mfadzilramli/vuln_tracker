module ProjectGroupsHelper
  def get_score_card(affected_hosts)
    cvss_count  = affected_hosts.joins(:vulnerabilities).pluck(:cvss_score).map(&:to_f).sum
    vuln_count  = affected_hosts.joins(:vulnerabilities).count
    # hosts_count = affected_hosts.count

    return (cvss_count/vuln_count).round(1)
  end

  def get_top_vulns_critical(affected_hosts)
    top_vulns = affected_hosts.joins(:vulnerabilities).where('severity == 4').group(:vulnerability_name).order('count_all DESC').limit(5).count
    return top_vulns
  end

  def get_top_hosts_critical(affected_hosts)
    top_hosts = affected_hosts.joins(:vulnerabilities).where('severity == 4').group(:host_ip).order('count_all DESC').limit(5).count
    return top_hosts
  end

  def get_top_ports_critical(affected_hosts)
    top_ports = affected_hosts.joins(:vulnerabilities).where('port != 0').group(:port).order('count_all DESC').limit(5).count
  end

end
