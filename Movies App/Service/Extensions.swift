//
//  Extensions.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 21/07/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func addGradientLayer(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}
