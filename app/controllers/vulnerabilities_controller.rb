class VulnerabilitiesController < ApplicationController
  before_action :set_vulnerability, :set_host, only: [:show]

  def show
  end

  private

  def set_vulnerability
    @vulns = Vulnerability.where(affected_host_id: params[:id]).order(severity: :desc)
  end

  def set_host
    @host = AffectedHost.find(params[:id])
  end

end
