function [R, orientation] = rand_rotation()
  theta = (rand()*2-1)*pi;
  phi = asin(rand()*2-1);
  orientation = params2vec(theta, phi);
  angle_axis = cross([0 0 1], orientation);
  angle = acos(dot([0 0 1], orientation));
  R = AngleAxis2RotationMatrix(orientation*rand()*2*pi)*AngleAxis2RotationMatrix(angle_axis/norm(angle_axis)*angle);
