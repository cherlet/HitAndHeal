//
//  RangeInputMenuItem.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 04.10.2023.
//

import UIKit

class RangeInputMenuItem: UIView {
    
    lazy var lowerBoundField = UITextField()
    lazy var upperBoundField = UITextField()
    private lazy var label = UILabel()

    init(fieldName: String, lowerBoundPlaceholder: String, upperBoundPlaceholder: String) {
        super.init(frame: .zero)
        
        lowerBoundField.placeholder = lowerBoundPlaceholder
        lowerBoundField.keyboardType = .numberPad
        lowerBoundField.borderStyle = .roundedRect
        
        upperBoundField.placeholder = upperBoundPlaceholder
        upperBoundField.keyboardType = .numberPad
        upperBoundField.borderStyle = .roundedRect
        
        label.text = fieldName
        label.font = UIFont(name: "BetterVCR", size: 12)
        label.textColor = ThemeColor.titleColor
        
        let dash = UILabel()
        dash.text = "-"
        
        [lowerBoundField, upperBoundField, label, dash].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            lowerBoundField.widthAnchor.constraint(equalToConstant: 56),
            lowerBoundField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            lowerBoundField.leadingAnchor.constraint(equalTo: leadingAnchor),
            lowerBoundField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dash.centerYAnchor.constraint(equalTo: lowerBoundField.centerYAnchor),
            dash.leadingAnchor.constraint(equalTo: lowerBoundField.trailingAnchor, constant: 4),
            
            upperBoundField.widthAnchor.constraint(equalToConstant: 56),
            upperBoundField.topAnchor.constraint(equalTo: lowerBoundField.topAnchor),
            upperBoundField.leadingAnchor.constraint(equalTo: dash.trailingAnchor, constant: 4),
            upperBoundField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
