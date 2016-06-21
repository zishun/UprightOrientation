function pred = angle_onenorm_min(preds, R)

  n = size(preds,2);
  errors = zeros(n, n);
  for i = 1:n
    preds(:,i) = R(:,:,1)*R(:,:,i)'*preds(:,i);
    preds(:,i) = preds(:,i)/norm(preds(:,i));
  end
  for i = 1:n
    for j = i+1:n
      angle = acos(preds(:,i)'*preds(:,j));
      errors(i,j) = angle;
      errors(j,i) = angle;
    end
  end
  onenorms = errors*ones(n,1);
  [~, idx] = min(onenorms);
  pred = preds(:,idx);