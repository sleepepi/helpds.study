require "application_system_test_case"

class DocumentsTest < ApplicationSystemTestCase
  setup do
    @category = categories(:general)
    @folder = folders(:mops)
    # @document = documents(:one)
    @editor = users(:editor)
  end

  test "update a document" do
    visit_login(@editor)
    visit category_folder_url(@category, @folder)
    screenshot("update-a-document")
    page.all(".dropdown-toggle")[2].click
    click_on "Edit"
    # click_element "[for='document_featured']" # TODO: Click checkbox.
    screenshot("update-a-document")
    click_on "Update Document"
    assert_text "blank.txt was successfully updated"
    assert_selector "h1", text: "Manual of Procedures"
    screenshot("update-a-document")
  end

  test "destroy a site" do
    visit_login(@editor)
    visit category_folder_url(@category, @folder)
    screenshot("destroy-a-document")
    # click_on "Actions", match: :second # The following is emulating this.
    page.all(".dropdown-toggle")[2].click
    screenshot("destroy-a-document")
    page.accept_confirm do
      click_on "Delete"
    end
    assert_text "Document was successfully deleted"
    screenshot("destroy-a-document")
  end
end
