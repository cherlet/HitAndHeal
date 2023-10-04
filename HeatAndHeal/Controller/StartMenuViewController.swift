//
//  StartMenuViewController.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 03.10.2023.
//

import UIKit

class StartMenuViewController: UIViewController {
    
    weak var delegate: StartMenuDelegate?
    
    // MARK: - Input view
    
    private let attackItem = InputMenuItem(fieldName: "Атака", placeholder: "1...30")
    private let defenseItem = InputMenuItem(fieldName: "Защита", placeholder: "1...30")
    private let healthItem = InputMenuItem(fieldName: "Здоровье", placeholder: "0...")
    private let damageItem = RangeInputMenuItem(fieldName: "Диапазон урона", lowerBoundPlaceholder: "min", upperBoundPlaceholder: "max")
    
    private let difficultyLevelItem: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Легкий", "Средний", "Сложный"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Старт", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray3
        isModalInPresentation = true
        
        setupMenu()
    }
    
    // MARK: - Setup method
    
    private func setupMenu() {
        // section labels
        let gameLabel = UILabel()
        gameLabel.text = "Hit & Heal"
        
        let charsSectionLabel = UILabel()
        charsSectionLabel.text = "Характеристики персонажа"
        
        let difficultyLevelLabel = UILabel()
        difficultyLevelLabel.text = "Сложность игры"
        
        // player characteristics setup
        let charsStackView = UIStackView(arrangedSubviews: [attackItem, defenseItem, healthItem, damageItem])
        charsStackView.axis = .vertical
        charsStackView.spacing = 20
        charsStackView.alignment = .leading
        
        // constraints
        [gameLabel, charsSectionLabel, charsStackView, difficultyLevelLabel, difficultyLevelItem, submitButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            charsSectionLabel.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 40),
            charsSectionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            charsStackView.topAnchor.constraint(equalTo: charsSectionLabel.bottomAnchor, constant: 20),
            charsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            difficultyLevelLabel.topAnchor.constraint(equalTo: charsStackView.bottomAnchor, constant: 40),
            difficultyLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            difficultyLevelItem.topAnchor.constraint(equalTo: difficultyLevelLabel.bottomAnchor, constant: 20),
            difficultyLevelItem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submitButton.widthAnchor.constraint(equalToConstant: 150),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // button target
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Other methods
    
    @objc private func submitButtonTapped() {
        guard let attack = Int(attackItem.field.text ?? ""),
              let defense = Int(defenseItem.field.text ?? ""),
              let health = Int(healthItem.field.text ?? ""),
              let lowerBound = Int(damageItem.lowerBoundField.text ?? ""),
              let upperBound = Int(damageItem.upperBoundField.text ?? "")
        else {
            return
        }
        
        guard attack >= 1 && attack <= 30,
              defense >= 1 && defense <= 30,
              health >= 0,
              lowerBound >= 1,
              upperBound >= lowerBound
        else {
            showAlert(message: "Некорректные характеристики")
            return
        }
        
        let damage = lowerBound...upperBound
        
        let difficultyLevel: DifficultyLevel
        switch difficultyLevelItem.selectedSegmentIndex {
        case 1:
            difficultyLevel = .medium
        case 2:
            difficultyLevel = .hard
        default:
            difficultyLevel = .easy
        }
        
        delegate?.startGame(attack: attack, defense: defense, health: health, damage: damage, difficultyLevel: difficultyLevel)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Delegate
protocol StartMenuDelegate: AnyObject {
    func startGame(attack: Int, defense: Int, health: Int, damage: ClosedRange<Int>,difficultyLevel: DifficultyLevel)
}

// MARK: - Enum of difficulty level
enum DifficultyLevel {
    case easy
    case medium
    case hard
}
