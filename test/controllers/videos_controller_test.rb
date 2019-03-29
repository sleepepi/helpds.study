# frozen_string_literal: true

require "test_helper"

# Assure users can view videos and editors can manage videos.
class VideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @video = videos(:one)
  end

  def video_params
    {
      name: "My Video", embed_url: "https://www.example.com/embed/VIDEOID"
    }
  end

  test "should get index as editor" do
    login(@editor)
    get videos_url
    assert_response :success
  end

  test "should get index as viewer" do
    login(@viewer)
    get videos_url
    assert_response :success
  end

  test "should get new as editor" do
    login(@editor)
    get new_video_url
    assert_response :success
  end

  test "should create video as editor" do
    login(@editor)
    assert_difference("Video.count") do
      post videos_url, params: { video: video_params }
    end
    assert_redirected_to video_url(Video.last)
  end

  test "should show video as editor" do
    login(@editor)
    get video_url(@video)
    assert_response :success
  end

  test "should show video as viewer" do
    login(@viewer)
    get video_url(@video)
    assert_response :success
  end

  test "should get edit as editor" do
    login(@editor)
    get edit_video_url(@video)
    assert_response :success
  end

  test "should update video as editor" do
    login(@editor)
    patch video_url(@video), params: { video: video_params }
    assert_redirected_to video_url(@video)
  end

  test "should destroy video as editor" do
    login(@editor)
    assert_difference("Video.count", -1) do
      delete video_url(@video)
    end
    assert_redirected_to videos_url
  end
end
