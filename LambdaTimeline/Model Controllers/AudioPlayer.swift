//
//  AudioPlayer.swift
//  LambdaTimeline
//
//  Created by Seschwan on 9/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayerDelegate: AnyObject {
    func playerDidChangeState(_ player: Player)
}

class Player: NSObject, AVAudioPlayerDelegate {
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    weak var delegate: PlayerDelegate?
    
    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
    var elapsedTime: TimeInterval {
        return audioPlayer?.currentTime ?? 0
    }
    
    var totalTime: TimeInterval {
        return audioPlayer?.duration ?? 0
    }
    
    var remainingTime: TimeInterval {
        return totalTime - elapsedTime
    }
    
    func playPause(song: URL? = nil) {
        if isPlaying {
            pause()
        } else {
            play(song: song)
        }
    }
    
    
    func play(song: URL? = nil) {
        let file = song ?? Bundle.main.url(forResource: "piano", withExtension: "mp3")!
        
        if audioPlayer == nil || audioPlayer?.url != file {
            audioPlayer = try! AVAudioPlayer(contentsOf: file)
            audioPlayer?.delegate = self
        }
        audioPlayer?.play()
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
            self?.notifyDelegate()
        }
        notifyDelegate()
    }
    
    func pause() {
        audioPlayer?.pause()
        timer?.invalidate()
        timer = nil
        notifyDelegate()
    }
    
    private func notifyDelegate() {
        delegate?.playerDidChangeState(self)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        notifyDelegate()
    }
    
}
