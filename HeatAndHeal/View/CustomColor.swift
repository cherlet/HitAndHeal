//
//  CustomColor.swift
//  HeatAndHeal
//
//  Created by Усман Махмутхажиев on 04.10.2023.
//

import UIKit

enum CustomColor: String {
    case TawnyColor
    case GingerbreadColor
    case HunterGreenColor
    case AmazonColor
    case BasilColor
    case PecanColor
    case HickoryColor
    case BloodColor
}

extension UIColor {
    static func appColor(_ name: CustomColor) -> UIColor! {
        return UIColor(named: name.rawValue)
    }
}

struct ThemeColor {
    static let tawnyColor = UIColor.appColor(CustomColor.TawnyColor)
    static let gingerbreadColor = UIColor.appColor(CustomColor.GingerbreadColor)
    static let hunterGreenColor = UIColor.appColor(CustomColor.HunterGreenColor)
    static let amazonColor = UIColor.appColor(CustomColor.AmazonColor)
    static let basilColor = UIColor.appColor(CustomColor.BasilColor)
    static let pecanColor = UIColor.appColor(CustomColor.PecanColor)
    static let hickoryColor = UIColor.appColor(CustomColor.HickoryColor)
    static let bloodColor = UIColor.appColor(CustomColor.BloodColor)
    
    static let backgroundColor = hunterGreenColor
    static let titleColor = hickoryColor
    static let buttonColor = gingerbreadColor
    static let buttonBorderColor = hickoryColor
}


