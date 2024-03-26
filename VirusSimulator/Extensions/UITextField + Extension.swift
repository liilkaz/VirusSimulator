//
//  UITextField + Extension.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 21.03.2024.
//

import UIKit
 
extension UITextField {
    convenience init(placeholder: String, borderWidth: CGFloat) {
        self.init()
        self.placeholder = placeholder
        self.layer.borderWidth = borderWidth
    }
}
