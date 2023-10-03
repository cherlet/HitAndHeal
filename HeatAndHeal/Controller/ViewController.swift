//
//  ViewController.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 03.10.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for number in 1...5 {
            let result = Int.random(in: 1...6)
            print(result)
            let isSuccess = result > 4 ? true : false
            print(isSuccess)
            break
        }
    }
    
}

