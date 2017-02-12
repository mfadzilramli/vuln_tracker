class VulnerabilitiesController < ApplicationController
  before_action :set_vulnerability, only: [:edit, :update, :destroy]

  def edit
  end

  def show
    @vulns = Vulnerability.where(affected_host_id: params[:id]).order(severity: :desc)
    @host = AffectedHost.find(params[:id])
  end

  def new
    @vuln = Vulnerability.new(affected_host_id: params[:host_id])
  end

  def create
    @vuln = Vulnerability.new(vuln_params)
    @vuln.last_seen = Time.now

    respond_to do |format|
      if @vuln.save
        @remedy = RemedyAction.new
        @remedy.status = 1
        @remedy.vulnerability_id = @vuln.id
        @remedy.save
        format.html { redirect_to show_vulnerability_path(@vuln.affected_host_id),
          notice: 'Vulnerability was successfully created.' }
        format.json { render :show, status: :created, location: @vuln }
      else
        format.html { render :new }
        format.json { render json: @vuln.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vuln.update(vuln_params)
        format.html { redirect_to show_vulnerability_path(@vuln.affected_host_id), notice: 'Vulnerability was successfully updated.' }
        format.json { render :show, status: :ok, location: @vuln }
      else
        format.html { render :edit }
        format.json { render json: @vuln.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vuln.destroy
    respond_to do |format|
      format.html { redirect_to show_vulnerability_path(@vuln.affected_host_id), notice: 'Vulnerability was successfully destroyed.' }
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
    @vuln = Vulnerability.find(params[:id])
  end

end
