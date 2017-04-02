class ReportFile < ApplicationRecord

  def self.update_remedy_action(file)
    spreadsheet = open_spreadsheet(file)
    affected_host = spreadsheet.sheet('Host Details').cell(1,'B')
    (6..spreadsheet.sheet('Host Details').last_row).each do |column|
      row = spreadsheet.sheet('Host Details').row(column)

      case row[6]
      when /open/i
        cell_status = 1
      when /in-progress/i
        cell_status = 2
      when /closed/i
        cell_status = 3
      else
        cell_status = 1
      end

      Vulnerability.find(row[2]).remedy_action.update(status: cell_status, remarks: row[7])
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
