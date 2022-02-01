//
//  ContentView.swift
//  NowPlaying WatchKit Extension
//
//  Created by Svensson, Andreas on 2/1/22.
//

import SwiftUI
import WatchKit

struct ContentView: View {
    let color: Color
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: NowPlayingView()) {
                Text("Now playing").foregroundColor(color)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(color: .blue)
    }
}
