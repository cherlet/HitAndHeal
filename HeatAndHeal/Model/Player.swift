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
    var healingPotionCount = 4
    
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
    }
}
