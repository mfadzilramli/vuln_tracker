module SourceFilesHelper

  def get_pie_data(hosts)
    severity_data =  hosts.joins(:vulnerabilities).group(:severity).count.values
    data = {
      labels: ["Low", "Medium", "High", "Critical"],
      datasets: [
        {
          data: severity_data,
          backgroundColor: [
            '#007E33',
            '#FFFF00',
            '#FF8800',
            '#CC0000'
          ]
        }
      ]
    }
    return data
  end

  def get_radar_data(hosts)
    vuln_groups = hosts.joins(:vulnerabilities).group(:plugin_family)
    groups = vuln_groups.count
    groups.each do |k,v|
      groups[k] = 0
    end

    data =
    {
      labels: vuln_groups.count.keys,
      datasets:
        [
          {
            label: 'Critical',
            borderColor: "rgba(255, 99, 132, 1)",
            pointBackgroundColor: "rgba(255,99,132,1)",
            pointBorderColor: "#fff",
            pointHoverBackgroundColor: "#fff",
            pointHoverBorderColor: "rgba(255,99,132,1)",
            data: groups.merge(vuln_groups.where('severity == 4').count).values
          },
          {
            label: 'High',
            borderColor: "rgba(255, 195, 0, 1)",
            pointBackgroundColor: "rgba(179,181,198,1)",
            pointBorderColor: "#fff",
            pointHoverBackgroundColor: "#fff",
            pointHoverBorderColor: "rgba(179,181,198,1)",
            data: groups.merge(vuln_groups.where('severity == 3').count).values
          },
          {
            label: 'Medium',
            borderColor: "rgba(249, 241, 4, 1)",
            pointBackgroundColor: "rgba(179,181,198,1)",
            pointBorderColor: "#fff",
            pointHoverBackgroundColor: "#fff",
            pointHoverBorderColor: "rgba(179,181,198,1)",
            data: groups.merge(vuln_groups.where('severity == 2').count).values
          },
          {
            label: 'Low',
            borderColor: "rgba(20, 215, 1, 1)",
            pointBackgroundColor: "rgba(179,181,198,1)",
            pointBorderColor: "#fff",
            pointHoverBackgroundColor: "#fff",
            pointHoverBorderColor: "rgba(179,181,198,1)",
            data: groups.merge(vuln_groups.where('severity == 1').count).values
          },
        ]
    }
    return data
  end

end
