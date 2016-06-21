function vec = params2vec(theta, phi)
  % theta \in [-pi, pi]
  % phi \in [-pi/2, pi/2]
  vec = [cos(phi)*cos(theta) cos(phi)*sin(theta) sin(phi)];
end