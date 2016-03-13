//
//  ViewController.swift
//  Sparta
//
//  Created by James Dyer on 3/11/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Properties
    
    var superfight: Game = Game.init(newgame: true, game: "SuperFight!")
    var player1: Player!
    var player2: Player!
    var btnSound: AVAudioPlayer!
    var backgroundMusicPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("bite", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        playBackgroundMusic("cave-music.mp3")
    }
    
    //Outlets
    
    @IBOutlet weak var player1SpartanImg: UIImageView!
    
    @IBOutlet weak var player1OrcImg: UIImageView!
    
    @IBOutlet weak var player2OrcImg: UIImageView!
    
    @IBOutlet weak var player2SpartanImg: UIImageView!
    
    @IBOutlet weak var player1OrcSelectLbl: UILabel!

    @IBOutlet weak var player1OrcSelectBtn: UIButton!
    
    @IBOutlet weak var player1SpartanSelectBtn: UIButton!
    
    @IBOutlet weak var player1SpartanSelectLbl: UILabel!
    
    @IBOutlet weak var player2OrcSelectBtn: UIButton!
    
    @IBOutlet weak var player2OrcSelectLbl: UILabel!
    
    @IBOutlet weak var player2SpartanSelectBtn: UIButton!
    
    @IBOutlet weak var player2SpartanSelectLbl: UILabel!
    
    @IBOutlet weak var startLbl: UILabel!
    
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var player1Btn: UIButton!
    
    @IBOutlet weak var player1Lbl: UILabel!
    
    @IBOutlet weak var player2Btn: UIButton!
    
    @IBOutlet weak var player2Lbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var powerUpBtn: UIButton!
    
    //Actions
    
    @IBAction func player1OrcPressed(sender: AnyObject) {
        playSound()
        hidePlayer1OnSelect()
        superfight.player1Orc(true)
    }
    
    @IBAction func player1SpartanPressed(sender: AnyObject) {
        playSound()
        hidePlayer1OnSelect()
        superfight.player1Spartan(true)
    }
    
    @IBAction func player2OrcPressed(sender: AnyObject) {
        playSound()
        hidePlayer2OnSelect()
        superfight.player2Orc(true)
    }
    
    @IBAction func player2SpartanPressed(sender: AnyObject) {
        playSound()
        hidePlayer2OnSelect()
        superfight.player2Spartan(true)
    }
    
    @IBAction func startBtnPressed(sender: AnyObject) {
        playSound()
        if (superfight.player1Spartan || superfight.player1Orc) && (superfight.player2Spartan || superfight.player2Orc) {
            startBtn.hidden = true
            startLbl.hidden = true
            startGame()
        } else {
            statusLbl.text = "Please Select Your Fighter First!"
        }
    }
    
    @IBAction func player1AttackBtnPressed(sender: AnyObject) {
        playSound()
        if self.powerUpBtn.hidden {
            player2Btn.hidden = true
            player2Lbl.hidden = true
            
            self.player2.hp -= self.player1.attack * self.player1.multiplier()
            
            if self.player2.hp >= 50 {
                statusLbl.text = "The \(self.player1.playerType) has damaged the \(self.player2.playerType)!"
            } else if self.player2.hp >= 35 {
                statusLbl.text = "Good Work! The \(self.player2.playerType) now has low health!"
            } else if self.player2.hp >= 0 {
                statusLbl.text = "You're close! The \(self.player2.playerType) is about to die!"
            }
            
            if player2.isAlive() == false {
                player2OrcImg.hidden = true
                player2SpartanImg.hidden = true
                player2Btn.hidden = true
                player2Lbl.hidden = true
                statusLbl.text = "You did it! The \(self.player2.playerType) has died!"
                
                let seconds = 2.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    
                    self.powerUpBtn.hidden = false
                    self.statusLbl.text = "Pick up the torch!"
                    
                })
            } else {
                    self.player2Lbl.hidden = false
                    self.player2Btn.hidden = false
                    self.player1Btn.hidden = true
                    self.player1Lbl.hidden = true
            }
        }
    }
    
    @IBAction func player2AttackBtnPressed(sender: AnyObject) {
        playSound()
        if self.powerUpBtn.hidden {
            player1Btn.hidden = true
            player1Lbl.hidden = true
        
            self.player1.hp -= self.player2.attack * self.player2.multiplier()
            
            if self.player1.hp >= 50 {
                statusLbl.text = "The \(self.player2.playerType) has damaged the \(self.player1.playerType)!"
            } else if self.player1.hp >= 35 {
                statusLbl.text = "Good Work! The \(self.player1.playerType) now has low health!"
            } else if self.player1.hp >= 0 {
                statusLbl.text = "You're close! The \(self.player1.playerType) is about to die!"
            }
            
            if player1.isAlive() == false {
                player1OrcImg.hidden = true
                player1SpartanImg.hidden = true
                player1Btn.hidden = true
                player1Lbl.hidden = true
                statusLbl.text = "You did it! The \(self.player1.playerType) has died!"
                
                let seconds = 2.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    
                    self.powerUpBtn.hidden = false
                    self.statusLbl.text = "Pick up the torch!"
                    
                })
            } else {
                    self.player1Lbl.hidden = false
                    self.player1Btn.hidden = false
                    self.player2Btn.hidden = true
                    self.player2Lbl.hidden = true
            }
        }
    }
    
    @IBAction func powerUpBtnPressed(sender: AnyObject) {
        playSound()
        powerUpBtn.hidden = true
        statusLbl.text = "Orc vs. Spartan"
        player1OrcSelectBtn.hidden = false
        player1OrcSelectLbl.hidden = false
        player1SpartanSelectBtn.hidden = false
        player1SpartanSelectLbl.hidden = false
        player2OrcSelectBtn.hidden = false
        player2OrcSelectLbl.hidden = false
        player2SpartanSelectBtn.hidden = false
        player2SpartanSelectLbl.hidden = false
        player1Btn.hidden = true
        player1Lbl.hidden = true
        player2Btn.hidden = true
        player2Lbl.hidden = true
        startBtn.hidden = false
        startLbl.hidden = false
        player1OrcImg.hidden = true
        player1SpartanImg.hidden = true
        player2OrcImg.hidden = true
        player2SpartanImg.hidden = true
        self.superfight.playerReset()
    }
    
    //Functions
    
    func hidePlayer1OnSelect() {
        player1OrcSelectBtn.hidden = true
        player1OrcSelectLbl.hidden = true
        player1SpartanSelectBtn.hidden = true
        player1SpartanSelectLbl.hidden = true
    }
    
    func hidePlayer2OnSelect() {
        player2OrcSelectBtn.hidden = true
        player2OrcSelectLbl.hidden = true
        player2SpartanSelectBtn.hidden = true
        player2SpartanSelectLbl.hidden = true
    }
    
    func startGame() {
        statusLbl.text = "Welcome To \(superfight.gameName)"
        
        if superfight.player1Orc {
            player1OrcImg.hidden = false
            player1 = Player.init(startingHp: 100, attackPwr: 16, playerType: "Orc")
        } else if superfight.player1Spartan {
            player1SpartanImg.hidden = false
            player1 = Player.init(startingHp: 110, attackPwr: 14, playerType: "Spartan")
        }
        
        if superfight.player2Orc {
            player2OrcImg.hidden = false
            player2 = Player.init(startingHp: 100, attackPwr: 16, playerType: "Orc")
        } else if superfight.player2Spartan {
            player2SpartanImg.hidden = false
            player2 = Player.init(startingHp: 110, attackPwr: 14, playerType: "Spartan")
        }
        
        player1Btn.hidden = false
        player1Lbl.hidden = false
        player2Btn.hidden = false
        player2Lbl.hidden = false
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func playBackgroundMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }

}

