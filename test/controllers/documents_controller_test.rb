# frozen_string_literal: true

require "test_helper"

# Test to assure documents can be modified and downloaded.
class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:general)
    @folder = folders(:mops)
    @document = documents(:one)
    @blank_doc = documents(:blank_doc)
    @blank_docx = documents(:blank_docx)
    @blank_pdf = documents(:blank_pdf)
    @blank_ppt = documents(:blank_ppt)
    @blank_pptx = documents(:blank_pptx)
    @blank_txt = documents(:blank_txt)
    @blank_zip = documents(:blank_zip)
    @editor = users(:editor)
    @viewer = users(:viewer)
  end

  def document_params
    {
      featured: "1"
    }
  end

  # test "should get index" do
  #   get documents_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_document_url
  #   assert_response :success
  # end

  # test "should create document" do
  #   assert_difference("Document.count") do
  #     post documents_url, params: { document: document_params }
  #   end
  #   assert_redirected_to document_url(Document.last)
  # end

  # test "should show document" do
  #   get document_url(@document)
  #   assert_response :success
  # end

  test "should get edit as editor" do
    login(@editor)
    get edit_document_url(@document)
    assert_response :success
  end

  test "should not get edit as viewer" do
    login(@viewer)
    get edit_document_url(@document)
    assert_redirected_to dashboard_url
  end

  test "should update document as editor" do
    login(@editor)
    patch document_url(@document), params: { document: document_params }
    assert_redirected_to category_folder_url(@category, @folder)
  end

  test "should not update document as viewer" do
    login(@viewer)
    patch document_url(@document), params: { document: document_params }
    assert_redirected_to dashboard_url
  end

  test "should destroy document as editor" do
    login(@editor)
    assert_difference("Document.count", -1) do
      delete document_url(@document)
    end
    assert_redirected_to category_folder_url(@category, @folder)
  end

  test "should not destroy document as viewer" do
    login(@viewer)
    assert_difference("Document.count", 0) do
      delete document_url(@document)
    end
    assert_redirected_to dashboard_url
  end

  test "should download DOC as viewer" do
    login(@viewer)
    get download_document_url(@blank_doc.folder.category, @blank_doc.folder, @blank_doc.filename)
    assert_equal File.binread(@blank_doc.file.path), response.body
    assert_response :success
  end

  test "should download DOCX as viewer" do
    login(@viewer)
    get download_document_url(@blank_docx.folder.category, @blank_docx.folder, @blank_docx.filename)
    assert_equal File.binread(@blank_docx.file.path), response.body
    assert_response :success
  end

  test "should download PDF as viewer" do
    login(@viewer)
    get download_document_url(@blank_pdf.folder.category, @blank_pdf.folder, @blank_pdf.filename)
    assert_equal File.binread(@blank_pdf.file.path), response.body
    assert_response :success
  end

  test "should download PPT as viewer" do
    login(@viewer)
    get download_document_url(@blank_ppt.folder.category, @blank_ppt.folder, @blank_ppt.filename)
    assert_equal File.binread(@blank_ppt.file.path), response.body
    assert_response :success
  end

  test "should download PPTX as viewer" do
    login(@viewer)
    get download_document_url(@blank_pptx.folder.category, @blank_pptx.folder, @blank_pptx.filename)
    assert_equal File.binread(@blank_pptx.file.path), response.body
    assert_response :success
  end

  test "should download TXT as viewer" do
    login(@viewer)
    get download_document_url(@blank_txt.folder.category, @blank_txt.folder, @blank_txt.filename)
    assert_equal File.binread(@blank_txt.file.path), response.body
    assert_response :success
  end

  test "should download ZIP as viewer" do
    login(@viewer)
    get download_document_url(@blank_zip.folder.category, @blank_zip.folder, @blank_zip.filename)
    assert_equal File.binread(@blank_zip.file.path), response.body
    assert_response :success
  end

  test "should redirect to DOC as public" do
    get download_document_url(@blank_doc.folder.category, @blank_doc.folder, @blank_doc.filename)
    assert_redirected_to category_folder_path(@blank_doc.folder.category, @blank_doc.folder, file: @blank_doc.filename)
  end

  test "should redirect to DOCX as public" do
    get download_document_url(@blank_docx.folder.category, @blank_docx.folder, @blank_docx.filename)
    assert_redirected_to category_folder_path(@blank_docx.folder.category, @blank_docx.folder, file: @blank_docx.filename)
  end

  test "should redirect to PDF as public" do
    get download_document_url(@blank_pdf.folder.category, @blank_pdf.folder, @blank_pdf.filename)
    assert_redirected_to category_folder_path(@blank_pdf.folder.category, @blank_pdf.folder, file: @blank_pdf.filename)
  end

  test "should redirect to PPT as public" do
    get download_document_url(@blank_ppt.folder.category, @blank_ppt.folder, @blank_ppt.filename)
    assert_redirected_to category_folder_path(@blank_ppt.folder.category, @blank_ppt.folder, file: @blank_ppt.filename)
  end

    test "should redirect to PPTX as public" do
    get download_document_url(@blank_pptx.folder.category, @blank_pptx.folder, @blank_pptx.filename)
    assert_redirected_to category_folder_path(@blank_pptx.folder.category, @blank_pptx.folder, file: @blank_pptx.filename)
  end

  test "should redirect to TXT as public" do
    get download_document_url(@blank_txt.folder.category, @blank_txt.folder, @blank_txt.filename)
    assert_redirected_to category_folder_path(@blank_txt.folder.category, @blank_txt.folder, file: @blank_txt.filename)
  end

  test "should redirect to ZIP as public" do
    get download_document_url(@blank_zip.folder.category, @blank_zip.folder, @blank_zip.filename)
    assert_redirected_to category_folder_path(@blank_zip.folder.category, @blank_zip.folder, file: @blank_zip.filename)
  end
end
