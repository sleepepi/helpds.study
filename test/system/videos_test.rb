# frozen_string_literal: true

require "application_system_test_case"

# Navigate videos.
class VideosTest < ApplicationSystemTestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
  end

  test "visit videos index" do
    visit_login(@viewer)
    visit videos_url
    assert_selector "h1", text: "Videos"
    screenshot("visit-videos-index")
  end

  test "create a video" do
    visit_login(@editor)
    visit videos_url
    screenshot("create-a-video")
    click_on "Add video"
    fill_in "video[name]", with: "Embedded Video"
    fill_in "video[embed_url]", with: "https://www.example.com/embed/VIDEOID"
    screenshot("create-a-video")
    click_on "Create Video"
    assert_text "Video was successfully created"
    assert_selector "h1", text: "Videos"
    screenshot("create-a-video")
  end

  test "update a video" do
    visit_login(@editor)
    visit videos_url
    screenshot("update-a-video")
    click_on "Actions", match: :first
    click_on "Edit"
    fill_in "video[name]", with: "Embedded Video"
    fill_in "video[embed_url]", with: "https://www.example.com/embed/VIDEOID"
    screenshot("update-a-video")
    click_on "Update Video"
    assert_text "Video was successfully updated"
    assert_selector "h1", text: "Videos"
    screenshot("update-a-video")
  end

  test "destroy a video" do
    visit_login(@editor)
    visit videos_url
    screenshot("destroy-a-video")
    click_on "Actions", match: :first
    screenshot("destroy-a-video")
    page.accept_confirm do
      click_on "Delete"
    end
    assert_text "Video was successfully deleted"
    screenshot("destroy-a-video")
  end
end
