# FODI_AI
This is an fairly simple AI made from 3 files but it's also simple to use.

## Usage
Add the files to your project.

To make a simple AI, you first need to create as many neurons as you want:

```
let neuron1 = Neuron.makeBasicNeuron()
```
It is important to create multiple neurons and not copy them.
Once you have your neurons, you can store them into groups.
There is also another initializer you can see it below.

```
let group1 = [neuron1, neuron2]
let group2 = [neuron3, neuron3, neuron4]
let group3 = [neuron5, neuron6, neuron7]
let group4 = [neuron8]
```
***Note:** The number of neurons in the last group is also the number of outputs*
Now you have to make the network.
```
neuralNetwork = NeuralNetwork(numberOfInputs: 1, neurons: [group1, group2, group3, group4])
```
Now it's time to train your network.
You'll need to run this a few times without quitting the application (as it would earase the memory and the network won't store itself) until it's going to work properly.
You'll need to adjust followering lines alot, this is just an example:

```
let result = try! neuralNetwork.fireWithInput([1])
print("Result: \(result)")
neuralNetwork.wasGood((10...50).contains(result.first!))
```

***Note:** The network is capable of much more complicated things. With a higher complexity, you may need more neuron groups and more neurons per group.*

If you did it right, your network should learn the task. How many times you need it to learn the task depends on the task's complexity.

There is no function to store the network, but since commit 2 you can use neuralNetwork.getData(), and neuralNetwork.updateNetworkWithData(_ data:). If
 you store the [Float] you get from NeuralNetwork.getData() and later use it in updateNetworkWithData(), you'll have the same network again. Note that updateNetworkWithData() can only run with a network with the same shape (number of groups, neurons/group) as the original network did.

 ## Initialize Neuron with more control
 If you use the initializer instead of the static function (*Neuron.makeBasicNeuron()*), there are more options for you.

```
Neuron(graphCalculator: ((Float) -> Float), connectionAdder: ([Float] -> Float))
```
**You can specify functions to make it adjusted to your needs.**

The `graphCalculator` function outputs what the neuron should return with a specified input. The default function in *Neuron.makeBasicNeuron()* is x^2.
The `connectionAdder` function takes an array of inputs and has only one output. The ouput will be the input for the *graphCalculator* function. The function gets the output of every connection it has to the neurons before. The connectionAdder function used in *Neuron.makeBasicNeuron()* adds every connection. Sometimes, it's more effective to multiply the connections, but you can use it however you want.

