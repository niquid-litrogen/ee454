function generate_video(maxframenum, imdir)
V = VideoWriter('testout.mp4', 'MPEG-4');
open(V)
for i=1:maxframenum
    picname  = ['out' num2str(i, '%04.f') '.jpg'];
    imloc = [imdir '/' picname];
    It = imread(imloc);
    writeVideo(V, It);
end

close(V);
