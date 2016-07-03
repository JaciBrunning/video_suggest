REQUIRED_GEMS = [
    "video_info", "json", "sinatra"
]

REQUIRED_GEMS.each do |a|
    puts `gem install #{a} --no-doc`
end