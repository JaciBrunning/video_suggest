require 'sinatra'
require 'json'

require_relative 'manq'

set :public_folder, "static"
set :port, 13337
set :bind, '0.0.0.0'

start_vlc

def f name
    File.join("static", name)
end

get '/' do
    send_file(f("submit.html"))
end

get '/manager' do
    send_file(f("manager.html"))
end

get '/list_approval' do
    JSON.generate(get_awaiting)
end

post '/_in/submit.html' do
    params['urls'].each { |x| push_for_approval x }
end

post '/_in/approve.html' do
    params['urls'].each  { |x| promote x }
end

post '/_in/reject.html' do 
    params['urls'].each  { |x| reject x }
end

post '/_in/prev.html' do
    vlc_prev
end

post '/_in/pp.html' do
    vlc_pp
end

post '/_in/play.html' do
    vlc_play
end

post '/_in/next.html' do
    vlc_next
end

post '/_in/save.html' do
    save_playlist
end

post '/_in/load.html' do
    load_playlist
end