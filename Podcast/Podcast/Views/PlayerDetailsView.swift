//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Jaycell on 16/09/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import UIKit
import AVKit

class PlayerDetailsView: UIView {
    
    var episode: Episode! {
        didSet {
            miniTitleLabel.text = episode.title
            titleLabel.text = episode.title
            authorLabel.text = episode.author
            
            playEpisode()
            
            guard let url = URL(string: episode.imageUrl ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
            miniEpisodeImageView.sd_setImage(with: url)
        }
    }
   
    fileprivate func playEpisode() {
        print("Trying to play episode at url:", episode.streamUrl)
        
        guard let url = URL(string: episode.streamUrl) else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    fileprivate func observePlayerCurrentTime() {
        let interval = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self](time) in
        self?.currentTimeLabel.text = time.toDisplayString()
        let durationTime = self?.player.currentItem?.duration
        self?.durationLabel.text = durationTime?.toDisplayString()
        self?.updateCurrentTimeSlider()
        }
    }
    
    fileprivate func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds =  CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage =  currentTimeSeconds / durationSeconds
        self.currentTimeSlider.value = Float(percentage)
    }
    
    var panGesture: UIPanGestureRecognizer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapMaximize)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        
        observePlayerCurrentTime()
        
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            [weak self] in
            print("Episode started playing")
            self? .enlargeEpisodeImageView()
        }
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
//        print("Panning")
        if gesture.state == .changed {
            handlePanChaged(gesture: gesture)
        } else if gesture.state == .ended {
            handlePanEnded(gesture: gesture)
        }
    }
    
    func handlePanChaged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        self.maximizedStackView.alpha = -translation.y / 200
        self.miniPlayerView.alpha = 1 + translation.y / 200
    }
    
    func handlePanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        print("Ended", velocity.y)
        UIView.animate(withDuration: 0.5 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
            if translation.y < -200 || velocity.y < -500 {
                let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
                mainTabBarController?.maximizePlayerDetails(episode: nil)
                gesture.isEnabled = false
            } else {
                self.miniPlayerView.alpha = 1
                self.maximizedStackView.alpha = 0
            }
        })
    }
    
    @objc func handleTapMaximize() {
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        mainTabBarController?.maximizePlayerDetails(episode: nil )
        panGesture.isEnabled = false
    }
    
    static func initFromNib() -> PlayerDetailsView {
        return Bundle.main.loadNibNamed("PlayerDetailsView", owner: self, options: nil)?.first as! PlayerDetailsView
    }
    
    deinit {
        print("PlayerDetailsView memory being reclaimed..")
    }
    
    //MARK:- IB Actions and Outlets
    
    @IBOutlet weak var miniTitleLabel: UILabel!
    @IBOutlet weak var miniEpisodeImageView: UIImageView!
    @IBOutlet weak var miniPlayPauseButton: UIButton! {
        didSet {
            miniPlayPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
            miniPlayPauseButton.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        }
    }
    @IBOutlet weak var miniFastForwardButton: UIButton! {
        didSet {
            miniFastForwardButton.addTarget(self, action: #selector(handleFastForward(_:)), for: .touchUpInside)
            miniFastForwardButton.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        }
    }

    @IBOutlet weak var maximizedStackView: UIStackView!
    @IBOutlet weak var miniPlayerView: UIView!
    
    @IBAction func handleCurrentTimeSliderChange(_ sender: Any) {
        let percentage = currentTimeSlider.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: Int32(1))
        
        player.seek(to: seekTime)
    }
    @IBAction func handleFastForward(_ sender: Any) {
        seekToCurrentTime(delta: 15)
    }
    @IBAction func handleRewind(_ sender: Any) {
        seekToCurrentTime(delta: -15)
    }
    
    fileprivate func seekToCurrentTime(delta: Int64) {
        let fifteenSeconds = CMTimeMake(value: delta, timescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(), fifteenSeconds)
        player.seek(to: seekTime)
    }
    
    @IBAction func handleVolumeChange(_ sender: UISlider) {
        player.volume = sender.value
    }
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBAction func handleDismiss(_ sender: Any) {
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        mainTabBarController?.minimizePlayerDetails()
        panGesture.isEnabled = true
    }
    
    fileprivate func enlargeEpisodeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = .identity
        })
    }
    
    fileprivate let shrunkenTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    
    fileprivate func shrinkEpisodeImageView(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = self.shrunkenTransform
        })
    }
    
    @IBOutlet weak var episodeImageView: UIImageView! {
        didSet {
            episodeImageView.layer.cornerRadius = 5
            episodeImageView.clipsToBounds = true
            episodeImageView.transform = shrunkenTransform
        }
    }
    
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet{
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            playPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        }
    }
    
    
    @objc func handlePlayPause() {
        print("Trying to play and pause")
        if player.timeControlStatus == .paused {
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            miniPlayPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            player.play()
            enlargeEpisodeImageView()
        } else {
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            miniPlayPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            player.pause()
            shrinkEpisodeImageView()
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
}

