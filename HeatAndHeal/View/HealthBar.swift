//
//  HealthBar.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 03.10.2023.
//

import UIKit

class HealthBar: UIView {
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0"
        label.font = UIFont(name: "BetterVCR", size: 14)
        return label
    }()
    
    init(color: UIColor, borderColor: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
        layer.borderWidth = 1
        layer.borderColor = borderColor.cgColor
        
        addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func updateValue(value: Int) {
        valueLabel.text = String(value)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
