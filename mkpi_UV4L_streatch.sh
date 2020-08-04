curl http://www.linux-projects.org/listing/uv4l_repo/lpkey.asc | sudo apt-key add -

# add the following line to the file /etc/apt/sources.list:
# sudo apt-add-repository "deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch stretch main"
sudo apt-add-repository http://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch
sudo apt-get update
sudo apt-get install uv4l uv4l-raspicam
sudo apt-get install uv4l-raspicam-extras
sudo service uv4l_raspicam restart


# sudo raspi-config
sudo rpi-update

sudo apt-get install vlc
uv4l --driver raspicam --auto-video_nr --framerate 25 --encoding=h264 --extension-presence=0
raspberrypi ~ $ sudo chrt -a -r -p 99 `pgrep uv4l`
Run the real-time VideoLan streaming server on your Raspberry Pi with the preferred resolution:

raspberrypi ~ $ cvlc -vvv v4l2c:///dev/video0:width=640:height=480:chroma=H264 --sout '#rtp{sdp=rtsp://:8554/}' --demux h264
although more appropriate in theory, the above command has been reported to leak memory because of some buggy versions of cvlc. If this is the case, try the following alternative command to run the server:

raspberrypi ~ $ dd if=/dev/video0 bs=1M | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:8554/}' --demux=h264
Now you can connect to your Raspberry Pi from the client, for example (don’t forget the final slash):

mypc ~ $ vlc rtsp://raspberrypi:8554/
where raspberrypi is the host name or IP of your RaspberryPi.

