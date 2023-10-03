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
        if healingPotionCount > 0 {
            health = min(health + healingPotionPower, maxHealth)
            healingPotionCount -= 1
        } else {
            print("Зелья исцеления кончились!")
        }
    }
}

// MARK: Text game
extension Player {
    func drinkPotion() {
        heal()
        print("🍺 Игрок пьет зелье и исцеляется. Текущее здоровье игрока: \(health)")
    }
    
    func attack(target: inout Monster) {
        let power = hitPower(target)
        
        if power >= target.health {
            target.health = 0
            print("🥳 Герой атакует! Нанесено \(power) урона. Здоровье игрока: \(target.health). Вы победили!")
        }
        
        target.health -= power
        print("⚔️ Игрок атакует! Нанесено \(power) урона. Здоровье монстра: \(target.health)")
    }
}
