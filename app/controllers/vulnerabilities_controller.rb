class VulnerabilitiesController < ApplicationController
  before_action :set_project_group, :set_affected_host, only: [ :index, :new, :create, :destroy, :edit, :update, :duplicate ]
  before_action :set_vulnerability, only: [ :edit, :duplicate, :update, :destroy ]

  def index
      @affected_host = AffectedHost.find(params[:affected_host_id])
      @vulnerabilities = Vulnerability.where(affected_host_id: params[:affected_host_id]).order('severity DESC').paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def show
    @affected_host = AffectedHost.find(params[:id])
    if params[:v_name].present?
      @vulnerabilities = Vulnerability.where(affected_host_id: params[:id]).where('name = ?', params[:v_name]).order('severity DESC').paginate(page: params[:page], per_page: 10)
    else
      @vulnerabilities = Vulnerability.where(affected_host_id: params[:id]).order('severity DESC').paginate(page: params[:page], per_page: 10)
    end

  end

  def new
    # @vulnerability = Vulnerability.new do |t|
    #   t.affected_host_id = @affected_host.id
    # end
    @vulnerability = Vulnerability.new
  end

  def duplicate
    @copy_vulnerability = Vulnerability.new do |t|
      t.port = @vulnerability.port
      t.service_name = @vulnerability.service_name
      t.protocol = @vulnerability.protocol
      t.severity = @vulnerability.severity
      t.plugin_id = @vulnerability.plugin_id
      t.name = @vulnerability.name
      t.plugin_family = @vulnerability.plugin_family
      t.cve = @vulnerability.cve
      t.cvss_score = @vulnerability.cvss_score
      t.cpe = @vulnerability.cpe
      t.vulnerability_date = @vulnerability.publish_date
      t.patch_date = @vulnerability.patch_date
      t.exploit_available = @vulnerability.exploit_available
      t.plugin_type = @vulnerability.plugin_type
      t.description = @vulnerability.description
      t.synopsis = @vulnerability.synopsis
      t.solution = @vulnerability.solution
      t.request = @vulnerability.request
      t.response = @vulnerability.response
      t.last_seen = @vulnerability.last_seen
    end
  end

  def create
    @vulnerability = Vulnerability.new(vuln_params) do |t|
      t.affected_host_id = @affected_host.id
    end

    @vulnerability.last_seen = Time.now

    respond_to do |format|
      if @vulnerability.save
        format.html { redirect_to project_group_affected_host_vulnerabilities_path(@project_group, @affected_host), notice: 'Vulnerability was successfully created.' }
        format.json { render :show, status: :created, location: @vulnerability }
      else
        format.html { render :new }
        format.json { render json: @vulnerability.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vulnerability.update(vuln_params)
        format.html { redirect_to project_group_affected_host_vulnerabilities_path(@project_group, @affected_host), notice: 'Vulnerability was successfully updated.' }
        format.json { render :show, status: :ok, location: @vulnerability }
      else
        format.html { render :edit }
        format.json { render json: @vulnerability.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @affected_host = AffectedHost.find(@vulnerability.affected_host_id)

    @vulnerability.destroy
    respond_to do |format|
      format.html { redirect_to project_group_affected_host_vulnerabilities_path(@project_group, @affected_host), notice: 'Vulnerability was successfully updated.' }
      format.json { render :show, status: :ok, location: @remedy_action }

      format.json { head :no_content }
    end
  end

  private

  def vuln_params
    params.fetch(:vulnerability, {}).permit(
      :name, :plugin_family, :cve, :cwe, :cvss_score, :port, :service_name, :affected_url,
      :protocol, :severity, :description, :synopsis, :solution, :request, :response, :parameter
      )
  end

  def set_project_group
    @project_group = ProjectGroup.find(params[:project_group_id])
  end

  def set_affected_host
    @affected_host = AffectedHost.find(params[:affected_host_id])
  end

  def set_vulnerability
    @vulnerability = Vulnerability.find(params[:id])
  end

end
