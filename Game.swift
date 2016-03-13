//
//  Game.swift
//  Sparta
//
//  Created by James Dyer on 3/11/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation

class Game {
    
    private var _newgame: Bool
    private var _game: String
    
    init(newgame: Bool, game: String) {
        self._newgame = newgame
        self._game = game
    }
    
    private var _player1Orc: Bool = false
    private var _player1Spartan: Bool = false
    private var _player2Orc: Bool = false
    private var _player2Spartan: Bool = false
    
    var gameName: String {
        get {
            return _game
        }
    }
    
    var player1Orc: Bool {
        get {
            return _player1Orc
        }
    }
    
    var player1Spartan: Bool {
        get {
            return _player1Spartan
        }
    }
    var player2Orc: Bool {
        get {
            return _player2Orc
        }
    }
    var player2Spartan: Bool {
        get {
            return _player2Spartan
        }
    }
    
    func player1Orc(status: Bool) {
        _player1Orc = status
    }
    
    func player1Spartan(status: Bool) {
        _player1Spartan = status
    }
    
    func player2Orc(status: Bool) {
        _player2Orc = status
    }
    
    func player2Spartan(status: Bool) {
        _player2Spartan = status
    }
    
    func playerReset() {
        _player1Orc = false
        _player1Spartan = false
        _player2Orc = false
        _player2Spartan = false

    }

}