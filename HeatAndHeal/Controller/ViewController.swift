//
//  ViewController.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 03.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textGameFight()
    }
    
    func textGameFight() {
        var player = Player(attack: 20, defense: 16, health: 30, damage: 1...6) // player object
        var monster = Monster(attack: 28, defense: 12, health: 50, damage: 1...8) // monster object
        
        for _ in 1...10 { // number of moves (now 10)
            let playerFocused = Bool.random() // true - player attack | false - monster attack
            
            if playerFocused {
                player.attack(target: &monster)
                if player.health < 3 { // heal if low hp
                    player.drinkPotion()
                }
            } else {
                monster.attack(target: &player)
            }
        }
    }
}


