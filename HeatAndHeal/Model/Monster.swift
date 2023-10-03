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
    }
}

// MARK: Text game
extension Monster {
    func attack(target: inout Player) {
        let power = hitPower(target)
        
        if power >= target.health {
            target.health = 0
            print("👻 Монстр атакует! Нанесено \(power) урона. Здоровье игрока: \(target.health). Вы умерли!")
        } else {
            target.health -= power
            print("👹 Монстр атакует! Нанесено \(power) урона. Здоровье игрока: \(target.health)")
        }
    }
}
