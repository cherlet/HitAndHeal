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
    
    var currentTurn = 0
    var turnLabel: UILabel!
    var playerHitLabel: UILabel!
    var monsterHitLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeColor.backgroundColor
        setupGame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupStartMenu()
    }
    
    // MARK: - Setup methods
    
    private func setupGame() {
        
        //health bars and buttons
        playerHealthBar = HealthBar(color: .systemGreen)
        monsterHealthBar = HealthBar(color: .systemRed)
        
        let attackButton = UIButton()
        attackButton.setTitle("Attack", for: .normal)
        attackButton.titleLabel?.font = UIFont(name: "BetterVCR", size: 16)
        attackButton.backgroundColor = ThemeColor.buttonColor
        attackButton.layer.borderWidth = 1
        attackButton.layer.borderColor = ThemeColor.buttonBorderColor?.cgColor
        attackButton.layer.cornerRadius = 8
        attackButton.addTarget(self, action: #selector(attackButtonTapped), for: .touchUpInside)
        
        healButton.setTitle("Heal", for: .normal)
        healButton.titleLabel?.font = UIFont(name: "BetterVCR", size: 16)
        healButton.backgroundColor = ThemeColor.buttonColor
        healButton.layer.borderWidth = 1
        healButton.layer.borderColor = ThemeColor.buttonBorderColor?.cgColor
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
        
        // turn labels
        turnLabel = UILabel()
        turnLabel.text = "Битва еще не началась"
        turnLabel.font = UIFont(name: "BetterVCR", size: 20)
        turnLabel.textColor = ThemeColor.titleColor
        
        playerHitLabel = UILabel()
        playerHitLabel.font = UIFont(name: "BetterVCR", size: 14)
        playerHitLabel.textColor = ThemeColor.titleColor
        
        monsterHitLabel = UILabel()
        monsterHitLabel.font = UIFont(name: "BetterVCR", size: 14)
        monsterHitLabel.textColor = ThemeColor.titleColor
        
        [turnLabel, playerHitLabel, monsterHitLabel].forEach {
            view.addSubview($0!)
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // constraints
        NSLayoutConstraint.activate([
            turnLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            turnLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerHealthBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerHealthBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            monsterHitLabel.bottomAnchor.constraint(equalTo: playerHealthBar.topAnchor, constant: -8),
            monsterHitLabel.centerXAnchor.constraint(equalTo: playerHealthBar.centerXAnchor),
            
            monsterHealthBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            monsterHealthBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            playerHitLabel.bottomAnchor.constraint(equalTo: monsterHealthBar.topAnchor, constant: -8),
            playerHitLabel.centerXAnchor.constraint(equalTo: monsterHealthBar.centerXAnchor),
            
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
        // health before attack
        let previousPlayerHealth = player.health
        let previousMonsterHealth = monster.health
        
        // attack realization
        player.attack(target: &monster)
        
        if monster.health <= 0 {
            monsterHealthBar.updateValue(value: 0)
            showAlert(message: "The monster is dead, you win!")
        } else {
            monsterHealthBar.updateValue(value: monster.health)
            monster.attack(target: &player)
            
            if player.health <= 0 {
                playerHealthBar.updateValue(value: 0)
                showAlert(message: "You died a brave death.")
            } else {
                playerHealthBar.updateValue(value: player.health)
            }
        }
        
        // fight log realization
        let playerHit = previousMonsterHealth - monster.health
        let monsterHit = previousPlayerHealth - player.health
        
        currentTurn += 1
        turnLabel.text = "Turn \(currentTurn)"
        
        if playerHit == 0 {
            playerHitLabel.text = "miss"
            playerHitLabel.textColor = .white
        } else {
            playerHitLabel.text = "-\(playerHit)"
            playerHitLabel.textColor = .red
        }
        
        if monsterHit == 0 {
            monsterHitLabel.text = "miss"
            monsterHitLabel.textColor = .white
        } else {
            monsterHitLabel.text = "-\(monsterHit)"
            monsterHitLabel.textColor = .red
        }
    }
    
    @objc func healButtonTapped() {
        if player.isHealingAvailable {
            player.heal()
            playerHealthBar.updateValue(value: player.health)
        } else {
            healButton.backgroundColor = ThemeColor.titleColor!.withAlphaComponent(0.5)
            healButton.isEnabled = false
        }
    }
    
    // MARK: - Other methods
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Fight over", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
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
            monster = Monster(attack: 15, defense: 15, health: 75, damage: 4...12)
        case .hard:
            monster = Monster(attack: 20, defense: 20, health: 100, damage: 10...18)
        }
        
        playerHealthBar.updateValue(value: player.health)
        monsterHealthBar.updateValue(value: monster.health)
        
        dismiss(animated: true)
    }
    
    func reloadObjects() {
        player = nil
        monster = nil
        turnLabel.text = "Fight not begun"
        playerHitLabel.text = nil
        monsterHitLabel.text = nil
        healButton.backgroundColor = ThemeColor.buttonColor
        healButton.isEnabled = true
    }
}







