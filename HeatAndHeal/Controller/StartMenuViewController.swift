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
    
    private let attackTextField: UITextField = {
        return InputTextField(placeholder: "Атака [1...30]")
    }()
    
    private let defenseTextField: UITextField = {
        return InputTextField(placeholder: "Защита [1...30]")
    }()
    
    private let healthTextField: UITextField = {
        return InputTextField(placeholder: "Здоровье [0...]")
    }()
    
    private let lowerBoundTextField: UITextField = {
        return InputTextField(placeholder: "Минимальный урон [1...]")
    }()
    
    private let upperBoundTextField: UITextField = {
        return InputTextField(placeholder: "Максимальный урон [1...]")
    }()
    
    
    
    private let difficultySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Легкий", "Средний", "Сложный"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        view.backgroundColor = .systemGray3
        isModalInPresentation = true
        modalPresentationStyle = .formSheet
        
        setupMenu()
    }
    
    // MARK: - Setup method
    
    private func setupMenu() {
        let stackView = UIStackView(arrangedSubviews: [attackTextField, defenseTextField, healthTextField, lowerBoundTextField, upperBoundTextField, difficultySegmentedControl, submitButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Other methods
    
    @objc private func submitButtonTapped() {
        guard let attack = Int(attackTextField.text ?? ""),
              let defense = Int(defenseTextField.text ?? ""),
              let health = Int(healthTextField.text ?? ""),
              let lowerBound = Int(lowerBoundTextField.text ?? ""),
              let upperBound = Int(upperBoundTextField.text ?? "")
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
        switch difficultySegmentedControl.selectedSegmentIndex {
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
