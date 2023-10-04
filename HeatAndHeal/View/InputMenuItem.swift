//
//  InputTextField.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 03.10.2023.
//

import UIKit

class InputMenuItem: UIView {
    
    lazy var field = UITextField()
    lazy var label = UILabel()

    init(fieldName: String, placeholder: String) {
        super.init(frame: .zero)
        
        field.placeholder = placeholder
        field.keyboardType = .numberPad
        field.borderStyle = .roundedRect

        
        label.text = fieldName + ":"
        label.font = UIFont(name: "BetterVCR", size: 14)
        label.textColor = ThemeColor.titleColor
        
        [field, label].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            field.widthAnchor.constraint(equalToConstant: 56),
            
            field.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            field.leadingAnchor.constraint(equalTo: leadingAnchor),
            field.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
