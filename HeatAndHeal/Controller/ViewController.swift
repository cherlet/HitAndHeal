//
//  ViewController.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 03.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var player: Player!
    var monster: Monster!
    
    var playerHealthBar: HealthBar!
    var monsterHealthBar: HealthBar!
    
    let healButton = UIButton()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        setupGame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupStartMenu()
    }
    
    // MARK: - Setup methods
    
    private func setupGame() {
        playerHealthBar = HealthBar(color: .systemGreen)
        monsterHealthBar = HealthBar(color: .systemRed)
        
        let attackButton = UIButton()
        attackButton.setTitle("Атака", for: .normal)
        attackButton.backgroundColor = UIColor.systemIndigo
        attackButton.layer.cornerRadius = 8
        attackButton.addTarget(self, action: #selector(attackButtonTapped), for: .touchUpInside)
        
        healButton.setTitle("Исцеление", for: .normal)
        healButton.backgroundColor = UIColor.systemIndigo
        healButton.layer.cornerRadius = 8
        healButton.addTarget(self, action: #selector(healButtonTapped), for: .touchUpInside)
        
        let healthBarWidth: CGFloat = 160
        let healthBarHeight: CGFloat = 30
        let buttonWidth: CGFloat = 120
        let buttonHeight: CGFloat = 30
        
        [playerHealthBar, monsterHealthBar].forEach {
            view.addSubview($0!)
            $0!.translatesAutoresizingMaskIntoConstraints = false
            
            $0!.widthAnchor.constraint(equalToConstant: healthBarWidth).isActive = true
            $0!.heightAnchor.constraint(equalToConstant: healthBarHeight).isActive = true
        }
        
        [attackButton, healButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            $0.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
            $0.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        }
        
        NSLayoutConstraint.activate([
            playerHealthBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerHealthBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            monsterHealthBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            monsterHealthBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            attackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            attackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            
            healButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            healButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
    }
    
    private func setupStartMenu() {
        let startMenuViewController = StartMenuViewController()
        startMenuViewController.delegate = self
        present(startMenuViewController, animated: true, completion: nil)
    }
    
    // MARK: - Button methods
    
    @objc func attackButtonTapped() {
        player.attack(target: &monster)
        
        if monster.health <= 0 {
            monsterHealthBar.updateValue(value: 0)
            showAlert(message: "Монстр убит, вы победили!")
        } else {
            monsterHealthBar.updateValue(value: monster.health)
            monster.attack(target: &player)
            
            if player.health <= 0 {
                playerHealthBar.updateValue(value: 0)
                showAlert(message: "Вы пали смертью храбрых..")
            } else {
                playerHealthBar.updateValue(value: player.health)
            }
        }
    }
    
    @objc func healButtonTapped() {
        if player.isHealingAvailable {
            player.heal()
            playerHealthBar.updateValue(value: player.health)
        } else {
            healButton.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.5)
            healButton.isEnabled = false
        }
    }
    
    // MARK: - Other methods
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Игра окончена", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
            self.setupStartMenu()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: StartMenuDelegate {
    func startGame(attack: Int, defense: Int, health: Int, damage: ClosedRange<Int>, difficultyLevel: DifficultyLevel) {
        reloadObjects()
        
        player = Player(attack: attack, defense: defense, health: health, damage: damage)
        
        switch difficultyLevel {
        case .easy:
            monster = Monster(attack: 10, defense: 10, health: 50, damage: 1...8)
        case .medium:
            monster = Monster(attack: 20, defense: 20, health: 75, damage: 4...12)
        case .hard:
            monster = Monster(attack: 30, defense: 30, health: 100, damage: 10...18)
        }
        
        playerHealthBar.updateValue(value: player.health)
        monsterHealthBar.updateValue(value: monster.health)
        
        dismiss(animated: true)
    }
    
    func reloadObjects() {
        player = nil
        monster = nil
        healButton.backgroundColor = UIColor.systemIndigo
        healButton.isEnabled = true
    }
}

// MARK: - Text game test function

extension ViewController {
    func textGame() {
        
        var player = Player(attack: 20, defense: 18, health: 25, damage: 1...6) // player object
        var monster = Monster(attack: 26, defense: 12, health: 30, damage: 1...8) // monster object
        
        while player.health != 0 && monster.health != 0 {
            
            let playerFocused = Bool.random() // true - player attack | false - monster attack
            
            if playerFocused {
                player.textAttack(target: &monster)
                if player.health < 10 { // heal if low hp
                    player.textHeal()
                }
            } else {
                monster.textAttack(target: &player)
            }
        }
    }
}







