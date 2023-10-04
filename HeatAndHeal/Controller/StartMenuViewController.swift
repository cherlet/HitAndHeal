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
    
    private let attackItem = InputMenuItem(fieldName: "Attack", placeholder: "1...30")
    private let defenseItem = InputMenuItem(fieldName: "Defense", placeholder: "1...30")
    private let healthItem = InputMenuItem(fieldName: "Health", placeholder: "0...")
    private let damageItem = RangeInputMenuItem(fieldName: "Damage range", lowerBoundPlaceholder: "min", upperBoundPlaceholder: "max")
    
    private let difficultyLevelItem: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Easy", "Medium", "Hard"])
        segmentedControl.backgroundColor = ThemeColor.buttonColor
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ThemeColor.buttonColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = ThemeColor.buttonBorderColor?.cgColor
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeColor.backgroundColor
        isModalInPresentation = true
        
        setupMenu()
    }
    
    // MARK: - Setup method
    
    private func setupMenu() {
        // section labels
        let gameLabel = UILabel()
        gameLabel.text = "Hit & Heal"
        gameLabel.font = UIFont(name: "BetterVCR", size: 24)
        gameLabel.textColor = ThemeColor.titleColor
        
        let charSection = UILabel()
        charSection.text = "Character"
        charSection.font = UIFont(name: "BetterVCR", size: 16)
        charSection.textColor = ThemeColor.titleColor
        
        let difficultyLevelSection = UILabel()
        difficultyLevelSection.text = "Difficulty level"
        difficultyLevelSection.font = UIFont(name: "BetterVCR", size: 16)
        difficultyLevelSection.textColor = ThemeColor.titleColor
        
        // player characteristics setup
        let damageStackView = UIStackView(arrangedSubviews: [damageItem.lowerBoundField, damageItem.dash , damageItem.upperBoundField])
        damageStackView.axis = .horizontal
        damageStackView.spacing = 4
        
        let charLabelStackView = UIStackView(arrangedSubviews: [attackItem.label, defenseItem.label, healthItem.label, damageItem.label])
        charLabelStackView.axis = .vertical
        charLabelStackView.spacing = 40
        charLabelStackView.alignment = .trailing
        
        let charFieldStackView = UIStackView(arrangedSubviews: [attackItem.field, defenseItem.field, healthItem.field, damageStackView])
        charFieldStackView.axis = .vertical
        charFieldStackView.spacing = 20
        charFieldStackView.alignment = .leading
        
        // dividers
        let gameLabelDivider = UIView()
        gameLabelDivider.backgroundColor = ThemeColor.basilColor
        
        let sectionDivider = UIView()
        sectionDivider.backgroundColor = ThemeColor.basilColor
        
        // constraints
        [gameLabel, charSection, charLabelStackView, charFieldStackView, difficultyLevelSection, difficultyLevelItem, submitButton, gameLabelDivider, sectionDivider].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            gameLabelDivider.widthAnchor.constraint(equalTo: view.widthAnchor),
            gameLabelDivider.heightAnchor.constraint(equalToConstant: 1),
            gameLabelDivider.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 32),
            
            charSection.topAnchor.constraint(equalTo: gameLabelDivider.bottomAnchor, constant: 40),
            charSection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            charLabelStackView.topAnchor.constraint(equalTo: charSection.bottomAnchor, constant: 48),
            charLabelStackView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -4),
            
            charFieldStackView.centerYAnchor.constraint(equalTo: charLabelStackView.centerYAnchor),
            charFieldStackView.leadingAnchor.constraint(equalTo: charLabelStackView.trailingAnchor, constant: 8),
            
            sectionDivider.widthAnchor.constraint(equalTo: view.widthAnchor),
            sectionDivider.heightAnchor.constraint(equalToConstant: 1),
            sectionDivider.topAnchor.constraint(equalTo: charFieldStackView.bottomAnchor, constant: 40),
            
            difficultyLevelSection.topAnchor.constraint(equalTo: sectionDivider.bottomAnchor, constant: 40),
            difficultyLevelSection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            difficultyLevelItem.topAnchor.constraint(equalTo: difficultyLevelSection.bottomAnchor, constant: 32),
            difficultyLevelItem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submitButton.widthAnchor.constraint(equalToConstant: 160),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // button setup
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButton.titleLabel?.font = UIFont(name: "BetterVCR", size: 20)
    }
    
    // MARK: - Other methods
    
    @objc private func submitButtonTapped() {
        guard let attack = Int(attackItem.field.text ?? ""),
              let defense = Int(defenseItem.field.text ?? ""),
              let health = Int(healthItem.field.text ?? ""),
              let lowerBound = Int(damageItem.lowerBoundField.text ?? ""),
              let upperBound = Int(damageItem.upperBoundField.text ?? "")
        else {
            showAlert(message: "Enter all characteristic")
            return
        }
        
        guard attack >= 1 && attack <= 30,
              defense >= 1 && defense <= 30,
              health >= 0,
              lowerBound >= 1,
              upperBound >= lowerBound
        else {
            showAlert(message: "Entered incorrect characteristics")
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
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
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
