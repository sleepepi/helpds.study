# frozen_string_literal: true

# Allows documents to be downloaded.
class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: [:download]
  before_action :check_editor!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_category_folder_document_or_redirect, only: [:download]
  before_action :find_document_or_redirect, only: [
    :show, :edit, :update, :destroy
  ]

  layout "layouts/full_page_sidebar"

  # # GET /docs
  # def index
  #   @documents = Document.all
  # end

  # # GET /documents/1
  # def show
  # end

  # GET /docs/:category/:folder/:filename
  def download
    if current_user
      params[:disposition] ||= "attachment" # "inline"
      @document.increment! :download_count
      if Rails.env.production?
        redirect_to @document.file.url(query: { "response-content-disposition" => params[:disposition] }), allow_other_host: true
      else
        send_file_if_present @document.file, disposition: params[:disposition]
      end
    else
      redirect_to category_folder_path(@document.folder.category, @document.folder, file: @document.filename, page: @document.page)
    end
  end

  # # GET /documents/new
  # def new
  #   @document = Document.new
  # end

  # # GET /documents/1/edit
  # def edit
  # end

  # # POST /documents
  # def create
  #   @document = Document.new(document_params)
  #   if @document.save
  #     redirect_to @document, notice: "Document was successfully created."
  #   else
  #     render :new
  #   end
  # end

  # PATCH /documents/1
  def update
    if @document.update(document_params)
      redirect_to category_folder_path(@document.folder.category, @document.folder), notice: "#{@document.filename} was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /documents/1
  def destroy
    @category = @document.folder.category
    @folder = @document.folder
    @document.destroy
    FilesJob.perform_later
    redirect_to category_folder_path(@category, @folder), notice: "Document was successfully deleted."
  end

  private

  def find_document_or_redirect
    @document = Document.find_by(id: params[:id])
    empty_response_or_root_path(documents_path) unless @document
  end

  def find_category_folder_document_or_redirect
    @category = Category.find_by_param(params[:category])
    @folder = @category.folders.find_by_param(params[:folder]) if @category
    @document = @folder.documents.find_by(filename: params[:filename]) if @folder
    unless @category && @folder && @document
      if @category && @folder
        empty_response_or_root_path(category_folder_path(@category, @folder))
      # elsif @category
      #   empty_response_or_root_path(category_path(@category))
      else
        empty_response_or_root_path(folders_path)
      end
    end
  end

  def document_params
    params.require(:document).permit(:featured, :keywords)
  end
end
