//
//  Creature.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 03.10.2023.
//

import Foundation

protocol Creature {
    var attack: Int { get set }
    var defense: Int { get set }
    var health: Int { get set }
    var damage: ClosedRange<Int> { get set }
}

extension Creature {
    func hit(target: inout Creature) {
        let attackModifier = attack - (target.defense + 1)
        let isSuccess: Bool = {
            for _ in 1...(max(attackModifier, 1)) {
                let throwingResult = Int.random(in: 1...6)
                
                if throwingResult > 4 {
                    return true
                }
            }
            return false
        }()
        
        if isSuccess {
            target.health -= Int.random(in: damage)
        }
    }
}
