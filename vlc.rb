require 'socket'

VLC_PATHS = { :win_64 => "C:/Program Files (x86)/VideoLAN/VLC/vlc.exe",
        :win_32 => "C:/Program Files/VideoLAN/VLC/vlc.exe",
        :mac => "/Applications/VLC.app/Contents/MacOS/VLC",
        :linux => "vlc" }

def os
    if (/Windows/ =~ ENV['OS']) != nil
      return :windows
    elsif (/darwin/ =~ RUBY_PLATFORM) != nil
      return :darwin
    else
      return :linux
    end
  end

def vlc
    op_s = os
    return (File.exist?(VLC_PATHS[:win_64]) ? VLC_PATHS[:win_64] : VLC_PATHS[:win_32]) if op_s == :windows
    return VLC_PATHS[:mac] if op_s == :darwin
    return VLC_PATHS[:linux] if op_s == :linux
  end

$vlc_socket = nil

def start_vlc
    args = ['--extraintf', 'rc', '--rc-host', Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3] + ":13377"]
    Process.spawn vlc, *args
    $vlc_socket = TCPSocket.new Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3], 13377
end

def vlc_queue link
    $vlc_socket.puts "enqueue #{link}"
end

def vlc_pp
    $vlc_socket.puts "pause"
end

def vlc_play
    $vlc_socket.puts "play"
end

def vlc_prev
    $vlc_socket.puts "prev"
end

def vlc_next
    $vlc_socket.puts "next"
end