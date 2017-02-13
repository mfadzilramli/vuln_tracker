module SourceFilesHelper

  def get_pie_data
    @severity_data =  @affected_hosts.joins(:vulnerabilities).group(:severity).count.values

    @data = {
      labels: ["Critical", "High", "Medium", "Low"],
      datasets: [
        {
          data: @severity_data,
          backgroundColor: [
            '#CC0000',
            '#FF8800',
            '#FFFF00',
            '#007E33'
          ]
        }
      ]
    }
  end

end
