//
//  ContentView.swift
//  Sample _swift
//
//  Created by matama on 2022/11/23.
//

import SwiftUI
import Network

struct Message {
    var text: String
    var isReceived: Bool
}


var running = true

func startConnection() {
    let myQueue = DispatchQueue(label: "8.8.8.8")
    let connection = NWConnection(host: "10.0.3.89", port: 5000, using: NWParameters.udp)
    connection.stateUpdateHandler = { (newState) in
        switch(newState) {
        case .ready:
            print("ready")
            sendMessage(connection)
        case .waiting(let error):
            print("waiting")
            print(error)
        case .failed(let error):
            print("failed")
            print(error)
        default:
            print("defaults")
            break
        }
    }
    connection.start(queue: myQueue)
}

func sendMessage(_ connection: NWConnection) {
    let data = "Hello, world!".data(using: .utf8)
    let completion = NWConnection.SendCompletion.contentProcessed { (error: NWError?) in
        print("送信完了")
        running = false
    }
    connection.send(content: data, completion: completion)
}



struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
    let a: () = startConnection()

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


