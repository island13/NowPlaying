//
//  NowPlayingApp.swift
//  NowPlaying WatchKit Extension
//
//  Created by Svensson, Andreas on 2/1/22.
//

import SwiftUI

@main
struct NowPlayingApp: App {
    
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) var delegate
    @State var color = Color.red
    
    var body: some Scene {
        WindowGroup {

            ContentView(color: color)
                
                .onReceive(delegate.$isInvoked.filter { $0 }) { isInvoked in
                    color = .green
                }

        }
    }
}
