class AffectedHostsController < ApplicationController
  def index
    @affected_hosts = AffectedHost.where(source_file_id: params[:source_id])
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def source_file_params
    params.fetch(:affected_hosts, {}).permit(:source_id)
  end

end
