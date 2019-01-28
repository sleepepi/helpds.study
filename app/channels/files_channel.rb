class FilesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "files_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
