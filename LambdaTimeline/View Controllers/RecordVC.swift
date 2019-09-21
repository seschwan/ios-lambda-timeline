//
//  RecordVC.swift
//  LambdaTimeline
//
//  Created by Seschwan on 9/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class RecordVC: UIViewController, PlayerDelegate, RecorderDelegate {
    
    @IBOutlet weak var playBtn: CustomButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let customButton = CustomButton()
    private let player = Player()
    private let recorder = Recorder()
    
    private lazy var timeFormatter: DateComponentsFormatter = {
        let f = DateComponentsFormatter()
        f.unitsStyle = .positional
        f.zeroFormattingBehavior = .pad
        f.allowedUnits = [.minute, .second]
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        recorder.delegate = self
        
        //        let fontSize = UIFont.systemFont(ofSize: 65)
        let font = UIFont.monospacedDigitSystemFont(ofSize: 65, weight: .regular)
        timeLbl.font = font
        
    }
    
    func playerDidChangeState(_ player: Player) {
        updateViews()
    }
    func recorderDidChangeState(_ recorder: Recorder) {
        updateViews()
    }
    
    func updateViews() {
        let isPlaying = player.isPlaying
        playBtn.setTitle(isPlaying ? "Pause" : "Play", for: .normal)
        timeLbl.text = timeFormatter.string(from: player.elapsedTime)
        progressView.progress = Float(player.elapsedTime / player.totalTime)
    }
    
    
    // MARK: - Actions
    
    @IBAction func recordBtnPressed(_ sender: CustomButton) {
        recorder.record()
    }
    
    @IBAction func playBtnPressed(_ sender: CustomButton) {
        player.playPause(song: recorder.currentFile)
    }
    
    @IBAction func stopBtnPressed(_ sender: CustomButton) {
        recorder.stop()
    }
    
    @IBAction func cancelBtnPressed(_ sender: CustomButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnPressed(_ sender: CustomButton) {
        //TODO: - Need to be able to post the recording now as a comment.
        
    }
    
}

/*
 1. Need to create a custom cell that will have the recording on it.
 2. Need to be able to play the recording from the cell's UI.
 3. 
 
 
 */
