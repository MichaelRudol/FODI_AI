//
//  NeuralNetworkLayer.swift
//  DataFlowTests
//
//  Created by Michael Rudolf on 24.10.23.
//

import Foundation

class NeuralNetworkLayer{
    var newNeurons: [Neuron]
    var oldNeurons: [Float]
    var connectionStrengths: [Float]
    private var lastConnectionVariation = [Float]()
    
    
    
    static func makeNetworkWithNeurons(_ neurons: [Neuron], oldNeuronNumber: Int) -> NeuralNetworkLayer{
        let connectionsCount = oldNeuronNumber*neurons.count//total number of connections in layer
        let neuralNetworkLayer = NeuralNetworkLayer(newNeurons: neurons, oldNeurons: [], connectionStrengths: [Float](repeating: 1.0, count: connectionsCount))
        return neuralNetworkLayer
    }
    
    
    func startProccessWithPrevious(_ neurons: [Float]){
        oldNeurons = neurons
        print("Starting with:")
        print(oldNeurons)
        chargeNeurons()
        fireNeurons()
        print("Current connection strengths: \(connectionStrengths)")
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
    
    
    func wasRight(_ wasRight: Bool){/*
        for connectionStrengthEn in connectionStrengths.enumerated() {
            var connectionStrength = connectionStrengths[connectionStrengthEn.offset]
            var connectionVariation = lastConnectionVariation[connectionStrengthEn.offset]
            if wasRight{
                connectionStrength += (connectionStrength / connectionVariation)*2
            }else{
                connectionStrength -= (connectionStrength / connectionVariation)*2
            }
        }
        print("Updated connection strenghts: \(connectionStrengths)")
                                     */
        guard !wasRight else {return}
        
        for connectionStrength in connectionStrengths.enumerated() {
            guard connectionStrength.offset > lastConnectionVariation.count && !lastConnectionVariation.isEmpty else {continue}
            let connectionVariation = lastConnectionVariation[connectionStrength.offset] * 0.9
            connectionStrengths[connectionStrength.offset] -= connectionStrength.element/connectionVariation
            //resetted nearly
        }
        randomVariation()
        
        
        
    }
    
    private func chargeNeurons(){
        for neuronEn in newNeurons.enumerated() {
            let neuron = neuronEn.element
            for connection in connectionStrengths.enumerated(){
                let connectionIsIt = ((connection.offset+2) % (neuronEn.offset+2)) == 0
                //neuron.precharchedConnections.append((oldNeurons[Int(neuronEn.offset / newNeurons.count)]) * connection.element)
                if connectionIsIt{
                    print("Charging connection \(connection)")
                    let corrispondingOldNeuronNumer = ceil(Float(connection.offset + 1)/Float(newNeurons.count))
                    let oldNeuronNumber = oldNeurons[Int(corrispondingOldNeuronNumer)-1]
                    neuron.precharchedConnections.append(connection.element*oldNeuronNumber)
                }
                newNeurons[neuronEn.offset] = neuron
            }
        }
    }
    
    private func fireNeurons(){
        for neuron in newNeurons {
            _ = neuron.fire()
        }
    }
    
    
    
    private func randomVariation(){
        lastConnectionVariation = []
        for connectionStrength in connectionStrengths.enumerated() {
            var variation = Float.random(in: 0...0.1)
            let variation2 = Float.random(in: 0...0.1)
            let shallBeNegativ = Bool.random()
            variation = variation + variation2
            
            if shallBeNegativ{
                variation = -variation
                print("madeVariationNegative")
            }
            
            connectionStrengths[connectionStrength.offset] += variation
            lastConnectionVariation.append(variation)
        }
    }
    
    init(newNeurons: [Neuron], oldNeurons: [Float], connectionStrengths: [Float]) {
        self.newNeurons = newNeurons
        self.oldNeurons = oldNeurons
        self.connectionStrengths = connectionStrengths
    }
}
