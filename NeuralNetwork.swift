//
//  NeuralNetwork.swift
//  DataFlowTests
//
//  Created by Michael Rudolf on 24.10.23.
//

import Foundation


class NeuralNetwork{
    private var layers = [NeuralNetworkLayer]()
    private var requiredNumberOfInputs = 0
    
    
    init(numberOfInputs: Int, neurons: [[Neuron]]) {
        var lastNeuronCount = numberOfInputs
        for neuronGroup in neurons {
            let neuralNetworkLayer = NeuralNetworkLayer.makeNetworkWithNeurons(neuronGroup, oldNeuronNumber: lastNeuronCount)
            layers.append(neuralNetworkLayer)
            lastNeuronCount = neuronGroup.count
        }
        requiredNumberOfInputs = numberOfInputs
    }
    
    func getData() -> [Float]{
       var currentData = [Float]()
       for layer in layers {
           for strength in layer.connectionStrengths {
               currentData.append(strength)
           }
       }
       return currentData
   }
   
   func earaseNetwork(){
       for layer in layers {
           for i in 0...layer.connectionStrengths.count-1{
               layer.connectionStrengths[i] = 1
           }
       }
   }
   
   func updateNetworkWithData(_ data: [Float]){
       var restData = data
       for layer in layers {
           for i in 0...layer.connectionStrengths.count-1 {
               layer.connectionStrengths[i] = restData.first ?? 1.0
               restData.removeFirst()
           }
       }
   }
    
    func fireWithInput(_ input: [Float])throws -> [Float]{
        guard input.count == requiredNumberOfInputs else {throw NeuralNetworkError.valueOfInputsDoesNotMatchRequirement}
        //now handle the neural networks
        var lastOutputs = input
        for layer in layers {
            layer.startProccessWithPrevious(lastOutputs)
            lastOutputs = []
            for neuron in layer.newNeurons {
                lastOutputs.append(neuron.outputValue!)
            }
        }
        return lastOutputs
    }
    
    func wasGood(_ truth: Bool){
        for layer in layers{
            layer.wasRight(truth)
        }
    }
    
    
    enum NeuralNetworkError: Error{
        case valueOfInputsDoesNotMatchRequirement
        
        var description: String {
            switch self {
            case .valueOfInputsDoesNotMatchRequirement:
                return "The number of inputs given to fireWithInput(input:) was not the amount of inputs specified when initializing this input. Change the number of inputs when initializing to match the number of inputs you need."
            }
        }
    }
}
