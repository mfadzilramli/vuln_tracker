class ReportController < ApplicationController

  before_action :set_host, only: [:generate, :generate_xlsx]

  def generate
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'report_file',
          locals: { obj: @host },
          page_size: "A4",
          footer: {
            font_size:  10,
            center:     '[page] of [topage]',
          },
          margin: {
            top:    15,
            bottom: 15,
            left:   10,
            right:  10
          }
      end
    end
  end

  def generate_xlsx
    respond_to do |format|
      format.html
      format.xlsx {
        render xlsx: 'xlstracker',
        locals: { host: @host },
        filename: "#{@host.host_ip}_report_tracker"
      }
    end
  end

  private

  def set_host
    @host = AffectedHost.find(params[:host_id])
  end
end
