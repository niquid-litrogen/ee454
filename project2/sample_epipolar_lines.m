function [epipolar_line_x, epipolar_line_y] = sample_epipolar_lines(joint_2D, epipole)
%Given two points on an epipolar line, returns x and y coordinates that can
%be plotted.
%inputs:
%    point_2D: 3x1 array, homogenous coordinates of a joint projected into a camera view.
%    epipole: 3x1 array, epipole location in homogenous camera coordinates.
%outputs:
%    epipolar_line_x: array of x coordinates along epipolar line with input endpoints. 
%    epiolar_line_y: array of y coordinates along epipolar line with input
%                     endpoints.

%vector of shape (1,num_lines) containing slopes of epipolar lines)
slope = (epipole(2) - joint_2D(2))/(epipole(1) - joint_2D(1));

epipolar_line_x = linspace(0,2000,100);
epipolar_line_y = slope * (epipolar_line_x - joint_2D(1)) + joint_2D(2); %point slope form: (y-y1)=slope*(x-x1)

end

