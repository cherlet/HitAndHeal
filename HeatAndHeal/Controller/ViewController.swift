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
        textGame()
    }
    
    func textGame() {
        var player = Player(attack: 20, defense: 18, health: 25, damage: 1...6) // player object
        var monster = Monster(attack: 26, defense: 12, health: 30, damage: 1...8) // monster object
        
        while player.health != 0 && monster.health != 0 {
            
            let playerFocused = Bool.random() // true - player attack | false - monster attack
            
            if playerFocused {
                player.attack(target: &monster)
                if player.health < 10 { // heal if low hp
                    player.drinkPotion()
                }
            } else {
                monster.attack(target: &player)
            }
        }
    }
}


