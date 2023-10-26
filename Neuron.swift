//
//  File.swift
//  DataFlowTests
//
//  Created by Michael Rudolf on 24.10.23.
//

import Foundation

class Neuron{
    var graphCalculator: ((_ x: Float)->Float)
    var connectionAdder: ((_ connections: [Float])->Float)
    
    var precharchedConnections = [Float]()
    var outputValue: Float? = nil
    
    static func makeBasicNeuron() -> Neuron{
        return Neuron { x in
            //calculate the graph
            return x * x
        } connectionAdder: { connections in
            var connectionWeight: Float = 0
            for connection in connections{
                connectionWeight += connection
            }
            return connectionWeight
        }

    }
    
    func fire() -> Float{
        outputValue = fireAmountWithConnections(precharchedConnections)
        precharchedConnections = []
        return outputValue!
    }
    
    func fireAmountWithConnections(_ connections: [Float]) -> Float{
        let x = connectionAdder(connections) //the total value of all connections
        let valueOnGraph = graphCalculator(x)
        return valueOnGraph
    }
    
    
    init(graphCalculator: @escaping(_ x: Float) -> Float, connectionAdder: @escaping(_ connections: [Float]) -> Float) {
        self.graphCalculator = graphCalculator
        self.connectionAdder = connectionAdder
    }
}
