class VulnerabilitiesController < ApplicationController
  before_action :set_vulnerability, only: [:edit, :update, :destroy]

  def edit
  end

  def show
    # @vulns = Vulnerability.where(affected_host_id: params[:id]).order(severity: :desc).paginate(page: params[:page], per_page: 15)
    @vulnerabilities = Vulnerability.where(affected_host_id: params[:id]).order('severity DESC').paginate(page: params[:page], per_page: 10)
    @host = AffectedHost.find(params[:id])
  end

  def new
    @vulnerability = Vulnerability.new(affected_host_id: params[:host_id])
  end

  def create
    @vulnerability = Vulnerability.new(vuln_params)
    @vulnerability.last_seen = Time.now

    respond_to do |format|
      if @vuln.save
        @remedy = RemedyAction.new
        @remedy.status = 1
        @remedy.vulnerability_id = @vulnerability.id
        @remedy.save
        format.html { redirect_to show_vulnerability_path(@vulnerability.affected_host_id),
          notice: 'Vulnerability was successfully created.' }
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
        format.html { redirect_to show_vulnerability_path(@vulnerability.affected_host_id), notice: 'Vulnerability was successfully updated.' }
        format.json { render :show, status: :ok, location: @vulnerability }
      else
        format.html { render :edit }
        format.json { render json: @vulnerability.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vulnerability.destroy
    respond_to do |format|
      format.html { redirect_to show_vulnerability_path(@vulnerability.affected_host_id), notice: 'Vulnerability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def vuln_params
    params.fetch(:vulnerability, {}).permit(
      :affected_host_id, :vulnerability_name, :plugin_family, :cve, :cvss_score, :port, :service_name,
      :protocol, :severity, :description, :synopsis, :solution, :output
      )
  end

  def set_vulnerability
    @vulnerability = Vulnerability.find(params[:id])
  end

end
