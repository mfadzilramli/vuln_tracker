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
            # borderColor: "rgba(255, 99, 132, 1)",
            borderColor: [ '#CC0000' ],
            pointBackgroundColor: "rgba(204, 0, 0, 1)",
            # pointBorderColor: "#fff",
            # pointHoverBackgroundColor: "#fff",
            # pointHoverBorderColor: "rgba(255,99,132,1)",
            data: groups.merge(vuln_groups.where('severity == 4').count).values
            # backgroundColor: [ '#CC0000' ]
          },
          {
            label: 'High',
            # borderColor: "rgba(255, 195, 0, 1)",
            borderColor: [ '#FF8800' ],
            # pointBackgroundColor: "rgba(179,181,198,1)",
            pointBackgroundColor: "rgba(255, 136, 0, 1)",
            # pointBorderColor: "#fff",
            # pointHoverBackgroundColor: "#fff",
            # pointHoverBorderColor: "rgba(179,181,198,1)",
            data: groups.merge(vuln_groups.where('severity == 3').count).values
            # backgroundColor: [ '#FF8800' ]
          },
          {
            label: 'Medium',
            # borderColor: "rgba(249, 241, 4, 1)",
            borderColor: [ '#FFFF00' ],
            pointBackgroundColor: "rgba(255, 255, 0, 1)",
            # pointBorderColor: "#fff",
            # pointHoverBackgroundColor: "#fff",
            # pointHoverBorderColor: "rgba(179,181,198,1)",
            data: groups.merge(vuln_groups.where('severity == 2').count).values
            # backgroundColor: [ '#FFFF00' ]
          },
          {
            label: 'Low',
            # borderColor: "rgba(20, 215, 1, 1)",
            borderColor: [ '#007E33' ],
            pointBackgroundColor: "rgba(0, 126, 51, 1)",
            # pointBorderColor: "#fff",
            # pointHoverBackgroundColor: "#fff",
            # pointHoverBorderColor: "rgba(179,181,198,1)",
            data: groups.merge(vuln_groups.where('severity == 1').count).values,
            # backgroundColor: [ '#007E33' ]
          },
        ]
    }
    return data
  end

end
