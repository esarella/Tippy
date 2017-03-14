//
//  Style.swift
//  Tippy
//
//  Created by Emmanuel Sarella on 3/11/17.
//  Copyright © 2017 Emmanuel Sarella. All rights reserved.
//

import Foundation
import UIKit

struct Style {

    static var darkColor = UIColor(rgb: 0x258685)
    static var lightColor = UIColor(rgb: 0xC2E9E7)
    static var darkMode = UIColor(rgb: 0x232923)

}

extension UIColor {
    convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
        self.init(
                red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgb & 0x0000FF) / 255.0,
                alpha: CGFloat(alpha)
        )
    }
}
