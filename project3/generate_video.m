function generate_video(maxframenum, imdir)
%Write project output to an mp4 file, using a directory of jpeg images as the video frames.
%inputs:
%    maxframenum: Number of frames to include in output video.
%    imdir: Directory of video frames, stored as jpegs. Frames are assumed to have
%           the title format out0001.jpg, out0002.jpg, ...
%outputs:
%    A new video file, titled "testout.mp4", is written. This video
%    shows background subtraction results.

%initalize video writer
V = VideoWriter('testout.mp4', 'MPEG-4');
open(V)

%Write each frame to video
for i=1:maxframenum
    picname  = ['out' num2str(i, '%04.f') '.jpg'];
    imloc = [imdir '/' picname];
    It = imread(imloc);
    writeVideo(V, It);
end

close(V);
