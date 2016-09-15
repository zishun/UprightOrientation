## Upright Orientation of 3D Shapes with Convolutional Networks

### Introduction

- This is the test code for 
>Zishun Liu, Juyong Zhang, Ligang Liu. [Upright Orientation of 3D Shapes with Convolutional Networks]. Graphical Models, 85: 22-29, 2016.

- We have tested the code on Debian 8 and Matlab R2014b.
- If you have any questions, please contact Zishun Liu via <liuzishun@gmail.com>.

### Code

1. The root folder contains a trained model and interfaces for testing. The regression network for four-legged/wheeled group in the paper is provided.
2. The folder "data" contains several mesh files sampled from our test set, whose upright orientations are all positive _z_-axis.
3. The folder "util" is for utilities such as mesh loading and random rotation generation.
4. The folder "voxelization" is a toolbox to convert mesh models to their volume representations.

### Usage

1. Build Caffe ([ND convolution](https://github.com/BVLC/caffe/pull/2049) is required) and its Matlab interface MatCaffe. Please refer to the official instructions [1](http://caffe.berkeleyvision.org/installation.html) and [2](http://caffe.berkeleyvision.org/tutorial/interfaces.html).
2. Compile the c-coded voxelization function in Matlab with ```mex ./voxelization/polygon2voxel_double.c```.
3. Edit the parameters in ```main.m``` and run it in Matlab. The results like the following would be printed:

        The prediction error is 2.7 degrees

## Thank you!

[Upright Orientation of 3D Shapes with Convolutional Networks]: http://dx.doi.org/10.1016/j.gmod.2016.03.001

