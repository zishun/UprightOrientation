%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% It is released under MIT license:

% Copyright (c) 2016 Princeton Vision Group

% Permission is hereby granted, free of charge, to any person 
% obtaining a copy of this software and associated documentation 
% files (the "Software"), to deal in the Software without 
% restriction, including without limitation the rights to use, copy, 
% modify, merge, publish, distribute, sublicense, and/or sell copies 
% of the Software, and to permit persons to whom the Software 
% is furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be 
% included in all copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
% NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
% HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
% WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
% DEALINGS IN THE SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function R = AngleAxis2RotationMatrix(angle_axis)

theta2 = dot(angle_axis,angle_axis);
if (theta2 > 0.0)
    % We want to be careful to only evaluate the square root if the
    % norm of the angle_axis vector is greater than zero. Otherwise
    % we get a division by zero.
    
    theta = sqrt(theta2);
    wx = angle_axis(1) / theta;
    wy = angle_axis(2) / theta;
    wz = angle_axis(3) / theta;
    
    costheta = cos(theta);
    sintheta = sin(theta);
    
    R(1+0, 1+0) =     costheta   + wx*wx*(1 -    costheta);
    R(1+1, 1+0) =  wz*sintheta   + wx*wy*(1 -    costheta);
    R(1+2, 1+0) = -wy*sintheta   + wx*wz*(1 -    costheta);
    R(1+0, 1+1) =  wx*wy*(1 - costheta)     - wz*sintheta;
    R(1+1, 1+1) =     costheta   + wy*wy*(1 -    costheta);
    R(1+2, 1+1) =  wx*sintheta   + wy*wz*(1 -    costheta);
    R(1+0, 1+2) =  wy*sintheta   + wx*wz*(1 -    costheta);
    R(1+1, 1+2) = -wx*sintheta   + wy*wz*(1 -    costheta);
    R(1+2, 1+2) =     costheta   + wz*wz*(1 -    costheta);
else
    % At zero, we switch to using the first order Taylor expansion.
    R(1+0, 1+0) =  1;
    R(1+1, 1+0) = -angle_axis(3);
    R(1+2, 1+0) =  angle_axis(2);
    R(1+0, 1+1) =  angle_axis(3);
    R(1+1, 1+1) =  1;
    R(1+2, 1+1) = -angle_axis(1);
    R(1+0, 1+2) = -angle_axis(2);
    R(1+1, 1+2) =  angle_axis(1);
    R(1+2, 1+2) = 1;
end
