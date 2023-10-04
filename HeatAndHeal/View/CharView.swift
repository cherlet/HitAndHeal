//
//  CharView.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 04.10.2023.
//

import UIKit

class CharView: UIView {
    
    private lazy var healingPotionsCount = 4
    private lazy var healingPotionsLabel = UILabel()

    init(image: String, value: Int) {
        super.init(frame: .zero)
        
        let charImage = UIImage(named: image)
        let charImageView = UIImageView(image: charImage)
        
        let charLabel = UILabel()
        charLabel.text = String(value)
        charLabel.font = UIFont(name: "BetterVCR", size: 14)
        charLabel.textColor = ThemeColor.titleColor
        
        [charImageView, charLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            charImageView.topAnchor.constraint(equalTo: topAnchor),
            charImageView.leadingAnchor.constraint(equalTo: leadingAnchor),

            charLabel.centerYAnchor.constraint(equalTo: charImageView.centerYAnchor),
            charLabel.leadingAnchor.constraint(equalTo: charImageView.trailingAnchor, constant: 4)
        ])
    }
    
    init(image: String, valueLowerBound: Int, valueUpperBound: Int) {
        super.init(frame: .zero)
        
        let charImage = UIImage(named: image)
        let charImageView = UIImageView(image: charImage)
        
        let charLowerBoundLabel = UILabel()
        let charUpperBoundLabel = UILabel()
        let dash = UILabel()
        
        charLowerBoundLabel.text = String(valueLowerBound)
        charUpperBoundLabel.text = String(valueUpperBound)
        dash.text = "-"
        
        [charLowerBoundLabel, charUpperBoundLabel, dash].forEach {
            $0.font = UIFont(name: "BetterVCR", size: 14)
            $0.textColor = ThemeColor.titleColor
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(charImageView)
        charImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            charImageView.topAnchor.constraint(equalTo: topAnchor),
            charImageView.leadingAnchor.constraint(equalTo: leadingAnchor),

            charLowerBoundLabel.centerYAnchor.constraint(equalTo: charImageView.centerYAnchor),
            charLowerBoundLabel.leadingAnchor.constraint(equalTo: charImageView.trailingAnchor, constant: 4),
            
            dash.centerYAnchor.constraint(equalTo: charImageView.centerYAnchor),
            dash.leadingAnchor.constraint(equalTo: charLowerBoundLabel.trailingAnchor, constant: 4),
            
            charUpperBoundLabel.centerYAnchor.constraint(equalTo: charImageView.centerYAnchor),
            charUpperBoundLabel.leadingAnchor.constraint(equalTo: dash.trailingAnchor, constant: 4)
        ])
    }
    
    init(image: String, value: Int, reversed: Bool) {
        super.init(frame: .zero)
        
        let charImage = UIImage(named: image)
        let charImageView = UIImageView(image: charImage)
        
        let charLabel = UILabel()
        charLabel.text = String(value)
        charLabel.font = UIFont(name: "BetterVCR", size: 14)
        charLabel.textColor = ThemeColor.titleColor
        
        [charImageView, charLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            charImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            charImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            charLabel.centerYAnchor.constraint(equalTo: charImageView.centerYAnchor),
            charLabel.trailingAnchor.constraint(equalTo: charImageView.leadingAnchor, constant: -4)
        ])
    }
    
    init(image: String, valueLowerBound: Int, valueUpperBound: Int, reversed: Bool) {
        super.init(frame: .zero)
        
        let charImage = UIImage(named: image)
        let charImageView = UIImageView(image: charImage)
        
        let charLowerBoundLabel = UILabel()
        let charUpperBoundLabel = UILabel()
        let dash = UILabel()
        
        charLowerBoundLabel.text = String(valueLowerBound)
        charUpperBoundLabel.text = String(valueUpperBound)
        dash.text = "-"
        
        [charLowerBoundLabel, charUpperBoundLabel, dash].forEach {
            $0.font = UIFont(name: "BetterVCR", size: 14)
            $0.textColor = ThemeColor.titleColor
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(charImageView)
        charImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            charImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            charImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            charUpperBoundLabel.centerYAnchor.constraint(equalTo: charImageView.centerYAnchor),
            charUpperBoundLabel.trailingAnchor.constraint(equalTo: charImageView.leadingAnchor, constant: -4),
            
            dash.centerYAnchor.constraint(equalTo: charImageView.centerYAnchor),
            dash.trailingAnchor.constraint(equalTo: charUpperBoundLabel.leadingAnchor, constant: -4),

            charLowerBoundLabel.centerYAnchor.constraint(equalTo: charImageView.centerYAnchor),
            charLowerBoundLabel.trailingAnchor.constraint(equalTo: dash.leadingAnchor, constant: -4)
        ])
    }
    
    
    
    init(image: String) {
        super.init(frame: .zero)
        
        let charImage = UIImage(named: image)
        let charImageView = UIImageView(image: charImage)
        
        healingPotionsLabel.text = "\(healingPotionsCount)/4"
        healingPotionsLabel.font = UIFont(name: "BetterVCR", size: 14)
        healingPotionsLabel.textColor = ThemeColor.titleColor
        
        [charImageView, healingPotionsLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            charImageView.topAnchor.constraint(equalTo: topAnchor),
            charImageView.leadingAnchor.constraint(equalTo: leadingAnchor),

            healingPotionsLabel.centerYAnchor.constraint(equalTo: charImageView.centerYAnchor),
            healingPotionsLabel.leadingAnchor.constraint(equalTo: charImageView.trailingAnchor, constant: 4)
        ])
    }
    
    func updatePotionsCount() {
        healingPotionsCount -= 1
        healingPotionsLabel.text = "\(healingPotionsCount)/4"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
