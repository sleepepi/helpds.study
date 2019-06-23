# frozen_string_literal: true

# Allow admin to configure projects.
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin!
  before_action :find_project_or_redirect, only: [
    :show, :edit, :update, :destroy
  ]

  layout "layouts/full_page_sidebar"

  # GET /projects
  def index
    @projects = Project.all.page(params[:page]).per(20)
  end

  # # GET /projects/1
  # def show
  # end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # # GET /projects/1/edit
  # def edit
  # end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new
    end
  end

  # PATCH /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  private

  def find_project_or_redirect
    @project = Project.find_by(id: params[:id])
    empty_response_or_root_path(projects_path) unless @project
  end

  def project_params
    params.require(:project).permit(:name, :access_token)
  end
end
