class ReportFilesController < ApplicationController
  before_action :set_report_file, only: [:show, :edit, :update, :destroy]
  before_action :set_host, only: [:generate]

  def generate
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'report_file',
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

  # GET /report_files
  # GET /report_files.json
  def index
    @report_files = ReportFile.all
  end

  # GET /report_files/1
  # GET /report_files/1.json
  def show
  end

  # GET /report_files/new
  def new
    @report_file = ReportFile.new
  end

  # GET /report_files/1/edit
  def edit
  end

  def import
    if !params[:report_file].nil?
      params[:report_file]['data'].each do |t|
        ReportFile.update_remedy_action(t)
      end
      redirect_to root_path
    else
      redirect_to new_report_file_path
    end
  end

  # POST /report_files
  # POST /report_files.json
  def create

    @report_file = ReportFile.new(report_file_params)

    respond_to do |format|
      if @report_file.save
        format.html { redirect_to @report_file, notice: 'Report file was successfully created.' }
        format.json { render :show, status: :ok, location: @report_file }
      else
        format.html { render :edit }
        format.json { render json: @report_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_files/1
  # PATCH/PUT /report_files/1.json
  def update
    respond_to do |format|
      if @report_file.update(report_file_params)
        format.html { redirect_to @report_file, notice: 'Report file was successfully updated.' }
        format.json { render :show, status: :ok, location: @report_file }
      else
        format.html { render :edit }
        format.json { render json: @report_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_files/1
  # DELETE /report_files/1.json
  def destroy
    @report_file.destroy
    respond_to do |format|
      format.html { redirect_to report_files_url, notice: 'Report file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_file
      @report_file = ReportFile.find(params[:id])
    end

    def set_host
      @host = AffectedHost.find(params[:host_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def report_file_params
      params.fetch(:report_file, {}).permit(:data => [])
    end
end
