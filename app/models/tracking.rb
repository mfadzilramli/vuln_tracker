class Tracking < ApplicationRecord

  def self.update_remedy_action(file)
    spreadsheet = open_spreadsheet(file)
    # affected_host = spreadsheet.sheet('Vulnerability Tracking').cell(1,'B')
    (8..spreadsheet.sheet('Vulnerability Tracking').last_row).each do |column|
      row = spreadsheet.sheet('Vulnerability Tracking').row(column)

      case row[11]
      when /open/i
        status = 1
      when /in-progress/i
        status = 2
      when /closed/i
        status = 3
      else
        status = 1
      end

      Vulnerability.find(row[4]).remedy_action.update(status: status, remarks: row[12])
      Vulnerability.find(row[4]).affected_host.update(host_fqdn: row[2])
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv"   then Roo::CSV.new(file.path, packed: false, file_warning: :ignore)
    when ".xls"   then Roo::Excel.new(file.path, packed: false, file_warning: :ignore)
    when ".xlsx"  then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore)
    else
      raise "Unknown file type: #{file.original_filename}"
    end
  end

end
