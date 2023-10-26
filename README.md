# FODI_AI
This is an fairly simple AI made from 3 files but it's also simple to use.

##Usage
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

***Note:** The network is capable of mcuh more complicated things. With a higher complexity, you may need more neuron groups and more neurons per group.*

If you did it right, your network should learn the task. How many times you need it to learn the task depends on the task's complexity.
