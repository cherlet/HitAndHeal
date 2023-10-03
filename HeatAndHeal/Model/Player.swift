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
        guard attack >= 1 && attack <= 30 else {
            fatalError("Некорректное значение атаки")
        }
        
        guard defense >= 1 && defense <= 30 else {
            fatalError("Некорректное значение защиты")
        }
        
        guard health >= 0 else {
            fatalError("Некорректное значение здоровья")
        }
        
        guard damage.lowerBound >= 1 && damage.upperBound >= damage.lowerBound else {
            fatalError("Некорректное значение урона")
        }
        
        
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

// MARK: Text game
extension Player {
    func textHeal() {
        let healingPotionPower = Int(Float(maxHealth) * 0.3)
        
        if isHealingAvailable {
            health = min(health + healingPotionPower, maxHealth)
            healingPotionCount -= 1
            print("🍺 Игрок пьет зелье и исцеляется. Текущее здоровье игрока: \(health)")
        } else {
            print("Зелья исцеления кончились!")
        }
    }
    
    func textAttack(target: inout Monster) {
        let power = hitPower(target)
        
        if power >= target.health {
            target.health = 0
            print("🥳 Герой атакует! Нанесено \(power) урона. Здоровье монстра: \(target.health). Вы победили!")
        } else {
            target.health -= power
            print("⚔️ Игрок атакует! Нанесено \(power) урона. Здоровье монстра: \(target.health)")
        }
    }
}
