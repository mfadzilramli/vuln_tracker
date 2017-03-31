class ReportController < ApplicationController

  before_action :set_host, only: [:generate]

  def generate
    # @vulnerabilities = @host.vulnerabilities

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'report_file',
          locals: { obj: @host },
          # :print_media_type => true,
          # orientation: 'Landscape',
          # dpi: 500,
          page_size: "A4",
          # :disable_smart_shrinking => true,
          footer: {
            font_size:  10,
            center:     '[page] of [topage]',
            # line: false,
            # spacing: 10,
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

  private

  def set_host
    @host = AffectedHost.find(params[:host_id])
  end
end
