require 'video_info'
require 'json'
require 'fileutils'
require_relative 'vlc'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

$awaiting_approval = []
$playlist = []

def push_for_approval url
    vi = VideoInfo.new(url) 
    $awaiting_approval << {
        "title" => vi.title,
        "url" => vi.url,
        "dur" => vi.duration
    }
end

def get_awaiting
    $awaiting_approval
end

def promote url
    obj = $awaiting_approval.find { |s| s["url"] == url }
    vlc_queue(obj["url"])
    $playlist.push(obj)
    $awaiting_approval.delete obj
end

def reject url
    obj = $awaiting_approval.find { |s| s["url"] == url }
    $awaiting_approval.delete obj
end

def save_playlist
    file = "_saves/"
    FileUtils.mkdir(file) unless File.exist?(file)
    File.write(file + ".submissions", JSON.generate($awaiting_approval))
    File.write(file + ".playlist", JSON.generate($playlist))
end

def load_playlist
    file = "_saves/"
    FileUtils.mkdir(file) unless File.exist?(file)
    $awaiting_approval = JSON.parse(File.read(file + ".submissions"))
    $playlist = JSON.parse(File.read(file + ".playlist"))
    $playlist.each { |s| vlc_queue(s["url"]) }
end