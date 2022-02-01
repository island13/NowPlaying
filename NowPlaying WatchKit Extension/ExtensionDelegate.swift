//
//  ExtensionDelegate.swift
//  NowPlaying WatchKit Extension
//
//  Created by Svensson, Andreas on 2/1/22.
//

import WatchKit
import os
import Combine
import WatchConnectivity
import MediaPlayer

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    private let session = WCSession.default
    
    
    private let logger = Logger()
    @Published var isInvoked = false
    
    override init() {
        super.init()
        session.delegate = self
        session.activate()
        
        _ = MPRemoteCommandCenter.shared()
    }
    
    func applicationDidFinishLaunching() {
        logger.debug("Watch launched")
    }
    
    func applicationDidBecomeActive() {
        logger.debug("Watch is active")
    }
    
    func applicationDidEnterBackground() {
        logger.debug("Watch is in background")
    }
    
    func handleRemoteNowPlayingActivity() {
        logger.debug("Now playing invoked")
        isInvoked = true
    }
}


extension ExtensionDelegate: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        logger.debug("Session state changed to \(session.isReachable ? "reachable" : "not reachable")")
    }
    
   
    
}
