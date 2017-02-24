class AffectedHostsController < ApplicationController
  before_action :set_affected_host, only: [:edit, :update, :destroy]

  def index
    @source_file = SourceFile.find(params[:source_id])
    if params[:search]
      @affected_hosts = AffectedHost.where(source_file_id: params[:source_id]).where(
      'host_ip LIKE ?', "%#{params[:search]}%"
      ).paginate(page: params[:page], per_page: 10)
    else
      @affected_hosts = AffectedHost.where(source_file_id: params[:source_id]).paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    #@affected_hosts = @affected_hosts.joins(:vulnerabilities).where("plugin_id == #{params[:plugin_id]}").uniq(:host_ip)
    @project_group = ProjectGroup.find(params[:project_group_id])
    @vulnerability_name = Vulnerability.where('plugin_id == ?', params[:plugin_id]).pluck(:vulnerability_name).first
    if params[:search]
      # @affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids).where(
      # 'host_ip LIKE ?', "%#{params[:search]}%"
      # ).paginate(page: params[:page], per_page: 15)
      @affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids).joins(:vulnerabilities).where(
      "plugin_id == #{params[:plugin_id]}").where(
      'host_ip LIKE ?', "%#{params[:search]}%"
      ).uniq(:host_ip).paginate(page: params[:page], per_page: 10)
    else
      #@affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids).paginate(page: params[:page], per_page: 15)
      @affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids).joins(:vulnerabilities).where(
      "plugin_id == #{params[:plugin_id]}").uniq(:host_ip).paginate(page: params[:page], per_page: 10)
    end
  end

  def create
    @affected_host = AffectedHost.new(affected_host_params)

    respond_to do |format|
      if @affected_host.save
        format.html { redirect_to source_file_path(@affected_host.source_file_id),
          notice: 'New affected host was successfully created.' }
        format.json { render :show, status: :created, location: @affected_host }
      else
        format.html { render :new }
        format.json { render json: @affected_host.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def new
    @affected_host = AffectedHost.new
  end

  def update
    def update
      respond_to do |format|
        if @affected_host.update(affected_host_params)
          format.html { redirect_to @affected_host, notice: 'Affected host was successfully updated.' }
          format.json { render :show, status: :ok, location: @affected_host }
          format.js
        else
          format.html { render :edit }
          format.json { render json: @affected_host.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @affected_host.destroy
    respond_to do |format|
      format.html { redirect_to search_affected_hosts_path(source_id: @affected_host.source_file_id),
        notice: 'Affected host was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_affected_host
    @affected_host = AffectedHost.find(params[:id])
  end

  # def source_file_params
  #   params.fetch(:affected_hosts, {}).permit(:source_id)
  # end

  def affected_host_params
    params.fetch(:affected_host, {}).permit(:source_file_id, :host_ip, :host_fqdn, :netbios_name, :mac_address, :operating_system, :plugin_id)
  end

end
