//
//  ContentView.swift
//  NowPlaying
//
//  Created by Svensson, Andreas on 2/1/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        
        
    
        Text("Phone")
            .font(.title)
        viewModel.activated.map {
            Button("Watch is activated: \($0)") {
                viewModel.activate()
            }
            .font(.headline)
                

        }
        Text("Hello, world!")
            .padding()
        if viewModel.audioPlayer.isPlaying {
            Button("Pause") {
                viewModel.pause()
            }
        } else {
            Button("Play") {
                viewModel.play()
            }

        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
