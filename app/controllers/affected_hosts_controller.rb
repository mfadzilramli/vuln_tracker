class AffectedHostsController < ApplicationController
  before_action :set_affected_host, only: [:edit, :update]
  before_action :set_source_file_id, only: [:index]

  def index
    if params[:search]
      @affected_hosts = AffectedHost.where(source_file_id: params[:source_id]).where('host_ip LIKE ?', "%#{params[:search]}%")
    else
      @affected_hosts = AffectedHost.where(source_file_id: params[:source_id])
    end
  end

  def show

  end

  def create
  end

  def edit
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
  end

  private

  def set_affected_host
    @affected_host = AffectedHost.find(params[:id])
  end

  # def source_file_params
  #   params.fetch(:affected_hosts, {}).permit(:source_id)
  # end

  def affected_host_params
    params.fetch(:affected_host, {}).permit(:host_fqdn, :netbios_name, :mac_address, :os)
  end

  def set_source_file_id
    @source_file = SourceFile.find(params[:source_id])
  end

end
