class ProjectGroupsController < ApplicationController
  before_action :set_project_group, only: [:search, :stats, :show, :edit, :update, :destroy]

  # GET /project_groups
  # GET /project_groups.json

  def search
    if params[:search]
      @affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids).where(
      'host_ip LIKE ?', "%#{params[:search]}%"
      ).paginate(page: params[:page], per_page: 10)
    end

    respond_to do |format|
      format.html
      format.json
      format.js
    end
    # else
    #   @affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids).paginate(page: params[:page], per_page: 10)
    # end
  end

  def stats
     @affected_hosts = AffectedHost.where(source_file_id: @project_group.source_file_ids)
  end

  def index
    @project_groups = ProjectGroup.all
  end

  # GET /project_groups/1
  # GET /project_groups/1.json
  def show
    @source_files = SourceFile.all
  end

  # GET /project_groups/new
  def new
    @project_group = ProjectGroup.new
  end

  # GET /project_groups/1/edit
  def edit
    @source_files = SourceFile.all
  end

  # POST /project_groups
  # POST /project_groups.json
  def create
    @project_group = ProjectGroup.new(project_group_params)

    respond_to do |format|
      if @project_group.save
        format.html { redirect_to @project_group, notice: 'Project group was successfully created.' }
        format.json { render :show, status: :created, location: @project_group }
      else
        format.html { render :new }
        format.json { render json: @project_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_groups/1
  # PATCH/PUT /project_groups/1.json
  def update
    respond_to do |format|
      if @project_group.update(project_group_params)
        format.html { redirect_to @project_group, notice: 'Project group was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_group }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @project_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_groups/1
  # DELETE /project_groups/1.json
  def destroy
    @project_group.destroy
    respond_to do |format|
      format.html { redirect_to project_groups_url, notice: 'Project group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_group
      @project_group = ProjectGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_group_params
      # if params.empty?
      #   params[:source_file_ids => ["0","0","0"]]
      # end

      params.fetch(:project_group, {}).permit(:name, :source_file_ids => [])
    end

end
