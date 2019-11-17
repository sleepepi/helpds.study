# frozen_string_literal: true

# Allows editors to manage videos
class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :check_editor!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_video_or_redirect, only: [:show, :edit, :update, :destroy]

  layout :choose_layout

  # GET /videos
  def index
    scope = Video.search_any_order(params[:search])
    @videos = scope_order(scope).page(params[:page]).per(40)
  end

  # # GET /videos/1
  # def show
  # end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # # GET /videos/1/edit
  # def edit
  # end

  # POST /videos
  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to @video, notice: "Video was successfully created."
    else
      render :new
    end
  end

  # PATCH /videos/1
  def update
    if @video.update(video_params)
      redirect_to @video, notice: "Video was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /videos/1
  def destroy
    @video.destroy
    redirect_to videos_path, notice: "Video was successfully deleted."
  end

  private

  def choose_layout
    current_user.editor? ? "layouts/full_page_sidebar" : "layouts/application"
  end

  def find_video_or_redirect
    @video = Video.find_by(id: params[:id])
    empty_response_or_root_path(videos_path) unless @video
  end

  def video_params
    params.require(:video).permit(:name, :embed_url)
  end

  def scope_order(scope)
    scope.order(Arel.sql(Video::ORDERS[params[:order]] || Video::DEFAULT_ORDER))
  end
end
