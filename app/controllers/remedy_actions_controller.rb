class RemedyActionsController < ApplicationController
  before_action :set_remedy_action, only: [:show, :update, :destroy]
  before_action :set_project_group, only: [:edit, :update]
  before_action :set_affected_host, only: [:edit]

  # GET /remedy_actions
  # GET /remedy_actions.json
  def index
    @remedy_actions = RemedyAction.all
  end

  # GET /remedy_actions/1
  # GET /remedy_actions/1.json
  def show
  end

  # GET /remedy_actions/new
  def new
    @remedy_action = RemedyAction.new
  end

  # GET /remedy_actions/1/edit
  def edit
    @remedy_action = RemedyAction.find_by_vulnerability_id(params[:vulnerability_id])
  end

  # POST /remedy_actions
  # POST /remedy_actions.json
  def create
    @remedy_action = RemedyAction.new(remedy_action_params)

    respond_to do |format|
      if @remedy_action.save
        format.html { redirect_to @remedy_action, notice: 'Remedy action was successfully created.' }
        format.json { render :show, status: :created, location: @remedy_action }
      else
        format.html { render :new }
        format.json { render json: @remedy_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /remedy_actions/1
  # PATCH/PUT /remedy_actions/1.json
  def update
    respond_to do |format|
      if @remedy_action.update(remedy_action_params)
        # TODO : need to shorten the query
        # vuln = Vulnerability.find(@remedy_action.vulnerability_id)
        # host = AffectedHost.find(vuln.affected_host_id)
        # done

        affected_host =  Vulnerability.find(@remedy_action.vulnerability_id).affected_host_id
        # format.html { redirect_to @remedy_action, notice: 'Remedy action was successfully updated.' }
        format.html { redirect_to project_group_affected_host_vulnerabilities_path(@project_group, affected_host), notice: 'Remedy action was successfully updated.' }
        format.json { render :show, status: :ok, location: @remedy_action }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @remedy_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /remedy_actions/1
  # DELETE /remedy_actions/1.json
  def destroy
    @remedy_action.destroy
    respond_to do |format|
      format.html { redirect_to remedy_actions_url, notice: 'Remedy action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_project_group
      @project_group = ProjectGroup.find(params[:project_group_id])
    end

    def set_affected_host
      @affected_host = AffectedHost.find(params[:affected_host_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_remedy_action
      @remedy_action = RemedyAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remedy_action_params
      params.fetch(:remedy_action, {}).permit(:status, :assigned_to, :remarks)
    end
end
