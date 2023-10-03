//
//  Monster.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 03.10.2023.
//

import Foundation

class Monster: Creature {
    var attack: Int
    var defense: Int
    var health: Int
    var damage: ClosedRange<Int>
    
    init(attack: Int, defense: Int, health: Int, damage: ClosedRange<Int>) {
        self.attack = attack
        self.defense = defense
        self.health = health
        self.damage = damage
    }
}
