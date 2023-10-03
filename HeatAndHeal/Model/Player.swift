//
//  Player.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 03.10.2023.
//

import Foundation

class Player: Creature {
    var attack: Int
    var defense: Int
    var health: Int
    var damage: ClosedRange<Int>
    
    let maxHealth: Int
    
    var isHealingAvailable = true
    var healingPotionCount = 4 {
        didSet {
            isHealingAvailable = healingPotionCount > 1 ? true : false
        }
    }
    
    init(attack: Int, defense: Int, health: Int, damage: ClosedRange<Int>) {
        
        self.attack = attack
        self.defense = defense
        self.health = health
        self.damage = damage
        
        maxHealth = health
    }
    
    func heal() {
        let healingPotionPower = Int(Float(maxHealth) * 0.3)
        health = min(health + healingPotionPower, maxHealth)
        healingPotionCount -= 1
    }
    
    func attack(target: inout Monster) {
        let power = hitPower(target)
        target.health -= power
    }
}
