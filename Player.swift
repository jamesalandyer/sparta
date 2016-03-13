//
//  Player.swift
//  Sparta
//
//  Created by James Dyer on 3/11/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation

class Player {
    
    var hp: Int
    private var _attack: Int
    private var _playerType: String
    
    init(startingHp: Int, attackPwr: Int, playerType: String) {
        self.hp = startingHp
        self._attack = attackPwr
        self._playerType = playerType
    }
    
    var attack: Int {
        get {
            return _attack
        }
    }
    
    var playerType: String {
        get {
            return _playerType
        }
    }
    
    func isAlive() -> Bool {
        if self.hp <= 0 {
            return false
        } else {
            return true
        }
    }
    
    func multiplier() -> Int {
        return Int(arc4random_uniform(2) + 1)
    }
    
}
