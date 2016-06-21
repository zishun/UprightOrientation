%--------------------------------------------------------------------
% Setting Paths and Parameters
%--------------------------------------------------------------------
off_file = './data/car_1.off';
num_TTA = 1; % num_TTA >= 1
             % num of rotations for test-time augmentation 
             % num_TTA=1 if do not use test-time augmentation

matcaffe_path = './caffe/matlab'; % path to /caffe/matlab
model_file = './regression.prototxt';
weights_file = './regression_fourlegged.caffemodel';
volume_size = 24; % fixed, donot modify
addpath(matcaffe_path);
addpath('./util');
addpath('./voxelization');

%--------------------------------------------------------------------
% Loading ConvNet
%--------------------------------------------------------------------
caffe.set_mode_cpu(); % modify this if you would like to use GPU mode
net = caffe.Net(model_file, weights_file, 'test');
net.blobs('data').reshape([volume_size volume_size volume_size ...
                          1 num_TTA]);
net.reshape();
data = zeros([volume_size volume_size volume_size 1 num_TTA]);
labels = zeros(3, num_TTA);
rots = zeros([3, 3, num_TTA]);

%--------------------------------------------------------------------
% Data Praparation: Shape Rotation and Voxelization
%--------------------------------------------------------------------
obj_original = off_loader(off_file);
obj.faces = obj_original.faces;
for i = 1:num_TTA
  [R, orientation] = rand_rotation();
  obj.vertices = obj_original.vertices * R';
  instance = polygon2voxel(obj, ...
             [volume_size, volume_size, volume_size], 'auto');
  instance = permute(instance,[3,2,1]);
  data(:,:,:,1,i) = instance(:,:,:);
  labels(:,i) = orientation(:);
  rots(:,:,i) = R(:,:);
end

%--------------------------------------------------------------------
% Making Prediction
%--------------------------------------------------------------------
net.blobs('data').set_data(data);
net.forward_prefilled();
preds = net.blobs('fc3').get_data();
label = labels(:,1);
if num_TTA == 1
  pred = preds(:,1);
else
  pred = angle_onenorm_min(preds, rots);
end
error = acos(label'*pred/norm(label)/norm(pred))/pi*180.0;
fprintf('The prediction error is %.1f degrees.\n', error);
