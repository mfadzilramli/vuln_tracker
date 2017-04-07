class ReportsController < ApplicationController
  before_action :set_host, only: [:generate]
  before_action :set_project_group, only: [:search, :insert, :delete]
  before_action :set_project_groups, only: [:index]
  before_action :set_report_items, only: [:print_all]

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
    @report = Report.new

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

  def print_all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "hosts_details",
          locals: { obj: @report_items },
          page_size: "A4",
          footer: { font_size:  10, center: '[page] of [topage]', },
          margin: { top:    15, bottom: 15, left:   10, right:  10 }
        Report.delete_all
      end
      # format.xlsx do
      #   render xlsx: 'report',
      #   locals: { host: @host },
      #   filename: "#{@host.host_ip}_report_tracker"
      # end
    end

  end

  def insert
    @project_group.affected_host_ids = @project_group.affected_host_ids << params[:affected_host_id]
  end

  def delete
    @affected_host_list = @project_group.affected_host_ids
    @affected_host_list.delete(params[:affected_host_id].to_i)
    @project_group.affected_host_ids = @affected_host_list
    # @project_group.affected_host_ids = @affected_host_list.delete(params[:affected_host_id].to_i)
  end

  private

  def set_report_items
    @report_items = Report.all.order('id ASC')
  end

  def set_host
    @host = AffectedHost.find(params[:affected_host_id])
  end

  def set_project_groups
    @project_groups = ProjectGroup.all
  end

  def set_project_group
    @project_group = ProjectGroup.find(params[:project_group_id])
  end

  # def report_params
  #   params.fetch(:project_group, {}).permit(:name, :affected_host_id, :project_group_id)
  # end
end
