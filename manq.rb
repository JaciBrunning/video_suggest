require 'video_info'
require_relative 'vlc'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

$awaiting_approval = []

def push_for_approval url
    vi = VideoInfo.new(url) 
    $awaiting_approval << vi
end

def get_awaiting
    $awaiting_approval.map do |a|
        {
            :title => a.title,
            :url => a.url,
            :dur => a.duration
        }
    end
end

def promote url
    obj = $awaiting_approval.find { |s| s.url == url }
    vlc_queue(obj.url)
    $awaiting_approval.delete obj
end

def reject url
    obj = $awaiting_approval.find { |s| s.url == url }
    $awaiting_approval.delete obj
end