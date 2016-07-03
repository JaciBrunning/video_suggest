# video_suggest
A simple (and hacky) project for LAN parties to suggest youtube videos for projector content.

# Installing
Installing is pretty simple. To install all the required gems, run
```
ruby install.rb
```
Please also ensure that you have VLC installed

# Using
On your projector computer, run
```
ruby run.rb
```
This will start a VLC instance that is being controlled by the video_suggest program. It will also
start a webserver on port `13377`. 

Other computers can access `http://<ip>:13377/` in their web browser to submit youtube URLs to be viewed.
You yourself can access `http://<ip>:13377/manager` in your web browser to approve or reject video suggestions, 
and control playback through the web interface.