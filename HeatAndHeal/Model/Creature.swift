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
    
    func hit(target: Creature) -> Int {
        let attackModifier = attack - (target.defense + 1)
        
        if isHit(attackModifier) {
            return Int.random(in: damage)
        } else {
            return 0
        }
    }
    
    func isHit(_ attackModifier: Int) -> Bool {
        var isSuccess = false
        
        for _ in 1...(max(attackModifier, 1)) {
            let throwingResult = Int.random(in: 1...6)
            
            if throwingResult > 4 {
                isSuccess = true
                break
            }
        }
        
        return isSuccess
    }
}
