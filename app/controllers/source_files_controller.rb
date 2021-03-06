class SourceFilesController < ApplicationController
  before_action :set_source_file, only: [:show, :edit, :update, :destroy]

  # GET /source_files
  # GET /source_files.json
  def index
    @source_files = SourceFile.all
  end

  # GET /source_files/1
  # GET /source_files/1.json
  def show
    @affected_hosts = AffectedHost.where(source_file_id: params[:id])
  end

  # GET /source_files/new
  def new
    @source_file = SourceFile.new
  end

  # GET /source_files/1/edit
  def edit
  end

  # POST /source_files
  # POST /source_files.json
  def create
    @source_file = SourceFile.new(source_file_params) do |t|
      if params[:source_file][:data]
        t.data      = params[:source_file][:data].read
        t.filename  = params[:source_file][:data].original_filename
        t.mime_type = params[:source_file][:data].content_type
      end
    end

    respond_to do |format|
      if @source_file.save
        SourceFile.to_db(@source_file)
        format.html { redirect_to @source_file, notice: 'Source file was successfully created.' }
        format.json { render :show, status: :created, location: @source_file }
      else
        format.html { render :new }
        format.json { render json: @source_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /source_files/1
  # PATCH/PUT /source_files/1.json
  def update
    respond_to do |format|
      if @source_file.update(source_file_params)
        # format.html { redirect_to @source_file, notice: 'Source file was successfully updated.' }
        format.html { redirect_to source_files_path, notice: 'Source file was successfully updated.' }
        format.json { render :show, status: :ok, location: @source_file }
      else
        format.html { render :edit }
        format.json { render json: @source_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_files/1
  # DELETE /source_files/1.json
  def destroy
    @source_file.destroy
    respond_to do |format|
      format.html { redirect_to source_files_path, notice: 'Source file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source_file
      @source_file = SourceFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_file_params
      params.fetch(:source_file, {}).permit(:title, :data)
    end

end
