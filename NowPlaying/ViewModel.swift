//
//  ViewModel.swift
//  NowPlaying
//
//  Created by Svensson, Andreas on 2/1/22.
//

import AVFoundation
import OSLog
import WatchConnectivity
import SwiftUI
import MediaPlayer

class ViewModel: NSObject, ObservableObject {
    let audioPlayer: AVAudioPlayer
    private let logger = Logger()
    @Published var activated: String?
    private var session: WCSession
    private let nowPlayingInfoCenter: MPNowPlayingInfoCenter
    
    
    
    init(audioSession: AVAudioSession = .sharedInstance(), bundle: Bundle = .main, session: WCSession = .default,
         remoteCommandCenter: MPRemoteCommandCenter = MPRemoteCommandCenter.shared(),
         nowPlayingInfoCenter: MPNowPlayingInfoCenter = .default()) {
        
        
        guard let url = bundle.url(forResource: "Urban Sunrise ", withExtension: "mp3") else { fatalError() }
        do {
            try audioSession.setCategory(.playback, mode: .spokenAudio, policy: .longFormAudio)
            
            
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            audioPlayer.prepareToPlay()
            
            try audioSession.setActive(true)
            
        } catch {
            logger.error("Error: \(error.localizedDescription)")
            fatalError()
        }
        self.session = session
        self.nowPlayingInfoCenter = nowPlayingInfoCenter

        super.init()

        session.delegate = self
        activate()
        
        remoteCommandCenter.pauseCommand.addTarget { event in
            self.pause()
            
            return .success
        }
        remoteCommandCenter.playCommand.addTarget { event in
            self.play()
            
            return .success
        }
        

    }
    
    func activate() {
        session.activate()
    }
    
    func play() {
        objectWillChange.send()
        audioPlayer.play()
        
        nowPlayingInfoCenter.nowPlayingInfo = [
            MPMediaItemPropertyTitle: "Example",

        ]
        
        logger.debug("Playing")
        
    }
    
    func pause() {
        self.objectWillChange.send()
        self.audioPlayer.pause()

    }
}

extension ViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.activated = activationState == .activated ? "Yes" : "No"
        }
        
        
        if let error = error {
            self.logger.error("Error activating: \(error.localizedDescription)")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        logger.debug("Inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        logger.debug("Did deactivate")
    }
    
}
