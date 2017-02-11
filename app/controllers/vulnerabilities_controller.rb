class VulnerabilitiesController < ApplicationController
  # before_action :set_vulnerability, only: [:show]

  def show
    @vulns = Vulnerability.where(affected_host_id: params[:id]).order(severity: :desc)
    @host = AffectedHost.find(params[:id])
  end

  def new
  end

  def create
    @vuln = Vulnerability.new(vuln_params)

    respond_to do |format|
      if @vuln.save
        format.html { redirect_to @vuln, notice: 'Source file was successfully created.' }
        format.json { render :show, status: :created, location: @vuln }
      else
        format.html { render :new }
        format.json { render json: @vuln.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def vuln_params
    params.fetch(:vulnerability, {})
  end

  # def set_host
  #   @host = AffectedHost.find(params[:id])
  # end

end
