# MLP Implemented in VHDL

## Abstract
Our objective is to implement a standard MLP (Multi Layer Perceptron) structure in hardware using VHDL. We achieve this by designing three main parts of the MLP. \
The three parts are as follow:

- Input layer
- Neurons which construct our hidden layer
- Output layer and activation function

The above three parts are what make up a standard MLP structure.

## Inference VS Learning
There are two approaches that can be taken. \
The first approach is to use pretrained weights which will allow us to perform inference steps by feeding a stream of data to our network. \
The second approach is to use a gradient descent algorithm to perform a learning step.

## Inference Method

We redesigned the same MLP neural network in a jupyter notebook using keras and sklearn modules. \
It follows the same 3 layer format of a standard MLP and has a 3 neuron hidden layer connected to a single input and output layer. \
The dataset used is the iris dataset with 4 inputs which were converted to int type. The conversion is necessary because the hardware implementation works with integers rather than floats. \
The weights produced from training the model will be hard coded into the digital circuit so that an inferencing process can be achieved. The pretrained weights will be used for predictions. 

The below image is the design of the implemented MLP (1 input layer of 4 inputs, 1 hidden layer of 3 neurons, 1 output layer with a sigmoid activation function):

![image](https://user-images.githubusercontent.com/51034490/173158875-0907e6d9-0e2a-42df-b75c-6babce553956.png)


