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
    
    var playerImageView: UIImageView!
    var monsterImageView: UIImageView!
    
    var playerHealthBar: HealthBar!
    var monsterHealthBar: HealthBar!
    
    let healButton = UIButton()
    var healingPotionsView: CharView!
    var playerHealLabel: UILabel!
    
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
        //player and monster images
        playerImageView = UIImageView(image: UIImage(named: "playerImage"))
        monsterImageView = UIImageView(image: UIImage(named: "monsterImage"))
        
        //health bars and buttons
        playerHealthBar = HealthBar(color: ThemeColor.amazonColor!, borderColor: ThemeColor.basilColor!)
        monsterHealthBar = HealthBar(color: ThemeColor.bloodColor!, borderColor: ThemeColor.hickoryColor!)
        
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
        turnLabel.font = UIFont(name: "BetterVCR", size: 20)
        turnLabel.textColor = ThemeColor.titleColor
        
        playerHitLabel = UILabel()
        playerHitLabel.font = UIFont(name: "BetterVCR", size: 14)
        
        monsterHitLabel = UILabel()
        monsterHitLabel.font = UIFont(name: "BetterVCR", size: 14)
        
        playerHealLabel = UILabel()
        playerHealLabel.font = UIFont(name: "BetterVCR", size: 14)
        playerHealLabel.textColor = .green
        
        // divider
        let divider = UIView()
        divider.backgroundColor = ThemeColor.basilColor
        
        [turnLabel, playerHitLabel, monsterHitLabel, playerImageView, monsterImageView, divider, playerHealLabel].forEach {
            view.addSubview($0!)
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // constraints
        NSLayoutConstraint.activate([
            
            // top view
            turnLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            turnLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerImageView.topAnchor.constraint(equalTo: turnLabel.bottomAnchor, constant: 60),
            playerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            playerHealthBar.centerYAnchor.constraint(equalTo: playerImageView.centerYAnchor),
            playerHealthBar.leadingAnchor.constraint(equalTo: playerImageView.centerXAnchor),
            
            playerHealLabel.centerYAnchor.constraint(equalTo: playerHealthBar.centerYAnchor),
            playerHealLabel.leadingAnchor.constraint(equalTo: playerHealthBar.trailingAnchor, constant: 8),
            
            // bot view
            attackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            attackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),

            healButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            healButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            
            monsterImageView.bottomAnchor.constraint(equalTo: healButton.topAnchor, constant: -88),
            monsterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            monsterHealthBar.centerYAnchor.constraint(equalTo: monsterImageView.centerYAnchor),
            monsterHealthBar.trailingAnchor.constraint(equalTo: monsterImageView.centerXAnchor),

            // middle view
            
            divider.widthAnchor.constraint(equalTo: view.widthAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            divider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            monsterHitLabel.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -12),
            monsterHitLabel.centerXAnchor.constraint(equalTo: divider.centerXAnchor),
            
            playerHitLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 12),
            playerHitLabel.centerXAnchor.constraint(equalTo: divider.centerXAnchor),
        ])
        
    }
    
    private func setupStartMenu() {
        let startMenuViewController = StartMenuViewController()
        startMenuViewController.delegate = self
        present(startMenuViewController, animated: true, completion: nil)
    }
    
    // MARK: - Button methods
    
    @objc func attackButtonTapped() {
        // turn ui reload
        playerHealLabel.text = nil
        
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
        // health before health
        let previousPlayerHealth = player.health
        
        if player.healingPotionCount > 1 {
            player.heal()
            playerHealthBar.updateValue(value: player.health)
            healingPotionsView.updatePotionsCount()
        } else {
            player.heal()
            playerHealthBar.updateValue(value: player.health)
            healingPotionsView.updatePotionsCount()
            healButton.backgroundColor = ThemeColor.titleColor!.withAlphaComponent(0.5)
            healButton.isEnabled = false
        }
        
        playerHealLabel.text = "+\(player.health - previousPlayerHealth)"
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
            monster = Monster(attack: 10, defense: 7, health: 50, damage: 1...8)
        case .medium:
            monster = Monster(attack: 15, defense: 12, health: 75, damage: 4...12)
        case .hard:
            monster = Monster(attack: 20, defense: 17, health: 100, damage: 10...18)
        }
        
        playerHealthBar.updateValue(value: player.health)
        monsterHealthBar.updateValue(value: monster.health)
        
        setupCharBars()
        dismiss(animated: true)
    }
    
    func setupCharBars() {
        healingPotionsView = CharView(image: "healImage")
        
        let playerCharBar = UIStackView(arrangedSubviews: [
            CharView(image: "attackImage", value: player.attack),
            CharView(image: "defenseImage", value: player.defense),
            CharView(image: "healthImage", value: player.maxHealth),
            CharView(image: "damageImage", valueLowerBound: player.damage.lowerBound, valueUpperBound: player.damage.upperBound),
            healingPotionsView
        ])
        
        playerCharBar.axis = .vertical
        playerCharBar.spacing = 24
        
        let monsterCharBar = UIStackView(arrangedSubviews: [
            CharView(image: "attackImage", value: monster.attack, reversed: true),
            CharView(image: "defenseImage", value: monster.defense, reversed: true),
            CharView(image: "healthImage", value: monster.health, reversed: true),
            CharView(image: "damageImage", valueLowerBound: monster.damage.lowerBound, valueUpperBound: monster.damage.upperBound, reversed: true)
        ])
        
        monsterCharBar.axis = .vertical
        monsterCharBar.spacing = 24
        
        [playerCharBar, monsterCharBar].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            playerCharBar.topAnchor.constraint(equalTo: playerImageView.bottomAnchor, constant: 8),
            playerCharBar.leadingAnchor.constraint(equalTo: playerImageView.leadingAnchor),
            
            monsterCharBar.bottomAnchor.constraint(equalTo: monsterImageView.topAnchor, constant: -8),
            monsterCharBar.trailingAnchor.constraint(equalTo: monsterImageView.trailingAnchor)
        ])
    }
    
    func reloadObjects() {
        player = nil
        monster = nil
        turnLabel.text = "Fight not begun"
        playerHitLabel.text = nil
        monsterHitLabel.text = nil
        playerHealLabel.text = nil
        healButton.backgroundColor = ThemeColor.buttonColor
        healButton.isEnabled = true
    }
}







