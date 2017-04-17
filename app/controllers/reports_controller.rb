class ReportsController < ApplicationController
  before_action :set_host, only: [:generate]
  before_action :set_project_group, only: [:search, :insert, :delete, :custom, :clear_selection, :generate_custom]
  before_action :set_project_groups, only: [:index]
  before_action :set_options, only: [:generate_custom]
  # before_action :set_report_items, only: [:generate_custom]

  def generate
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@host.host_ip}_vuln_details",
          locals: { obj: @host },
          page_size: "A4",
          footer: { font_size:  10, center: '[page] of [topage]', },
          margin: { top:    15, bottom: 15, left:   10, right:  10 }
      end
      format.xlsx do
        render xlsx: 'report',
        locals: { host: @host },
        filename: "#{@host.host_ip}_report_tracker"
      end
    end
  end

  def search
    # @report = Report.new
    if params[:search]
      @affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids).where(
      'host_ip LIKE ?', "%#{params[:search]}%"
      ).paginate(page: params[:page], per_page: 10)
    else
      @affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids).paginate(page: params[:page], per_page: 10)
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def index
  end

  def generate_custom
    respond_to do |format|
      # check if parameter is nil
      if params[:report].nil?
        raise "no severity is selected"
      else
        @severity = params[:report].values.map{ |x| x }
      end
      @filename = "custom_report-#{DateTime.now.to_i}"

      format.html
      format.pdf do
        render pdf: @filename,
          disposition: 'attachment',
          template: "reports/generate_custom",
          locals: { project_group: @project_group, severity: @severity },
          page_size: "A4",
          encoding: "UTF-8",
          footer: { font_size:  10, center: '[page] of [topage]', },
          margin: { top:    15, bottom: 15, left:   10, right:  10 }
      end
      format.xlsx do
        render xlsx: 'generate_custom',
        locals: { project_group: @project_group, severity: @severity, options: params[:options] },
        filename: "#{@project_group.name}_custom-report-#{DateTime.now.to_i}"
      end
      format.xml
    end
  end

  def clear_selection
    respond_to do |format|
      if @project_group.reports.delete_all.nil?
        format.html { redirect_to search_reports_path(@project_group), notice: 'All report items selection was successfully deleted.' }
      else
        format.html { render root_path }
      end
    end
  end

  def custom
  end

  def insert
    @project_group.affected_host_ids = @project_group.affected_host_ids << params[:affected_host_id]
  end

  def delete
    @affected_host_list = @project_group.affected_host_ids
    @affected_host_list.delete(params[:affected_host_id].to_i)
    @project_group.affected_host_ids = @affected_host_list
  end

  private

  # def set_report_items
  #   @report_items = Report.all.order('id ASC')
  # end

  def set_host
    @host = AffectedHost.find(params[:affected_host_id])
  end

  def set_project_groups
    @project_groups = ProjectGroup.all
  end

  def set_project_group
    @project_group = ProjectGroup.find(params[:project_group_id])
  end

  def set_options
    @options = params[:options]
  end
end
