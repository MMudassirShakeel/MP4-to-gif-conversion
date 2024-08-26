%% Convert MP4 into gif file using MATLAB

% Step 1: Read the video file
videoFile = '3R_robot.mp4'; % Replace with your video file
video = VideoReader(videoFile);

% Step 2: Define the start and end times for trimming
startTime = 0; % Start time in seconds
endTime = 9;  % End time in seconds

% Check if the end time exceeds the video duration
if endTime > video.Duration
    endTime = video.Duration;
end

% Step 3: Initialize the GIF file
gifFile = '3R_articulated.gif'; % Output GIF file name

% Step 4: Read and convert frames within the specified time range
frameRate = video.FrameRate;
startFrame = max(1, round(startTime * frameRate));  % Ensure startFrame is at least 1
endFrame = round(endTime * frameRate);

for frameIdx = startFrame:endFrame
    % Read the current frame
    video.CurrentTime = (frameIdx-1) / frameRate;
    frame = readFrame(video);
    
    % Convert the frame to an indexed image
    [imind, cm] = rgb2ind(frame, 256);
    
    % Write the frame to the GIF file
    if frameIdx == startFrame
        imwrite(imind, cm, gifFile, 'gif', 'Loopcount', inf, 'DelayTime', 1/frameRate);
    else
        imwrite(imind, cm, gifFile, 'gif', 'WriteMode', 'append', 'DelayTime', 1/frameRate);
    end
end

disp('GIF creation complete.');
