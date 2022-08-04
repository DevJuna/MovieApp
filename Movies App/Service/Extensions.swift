//
//  Extensions.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 21/07/2022.
//

import Foundation
import UIKit


fileprivate var loadingView: UIView?

extension UIView {
    
    func addGradientLayer(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{ $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIViewController {
    
    func showSpinner() {
        let spinner = UIActivityIndicatorView()
        
        loadingView = UIView(frame: UIScreen.main.bounds)
        loadingView?.backgroundColor = UIColor(named: "#00000080")
        spinner.transform = CGAffineTransform(scaleX: 2, y: 2)
        spinner.color = UIColor(named: "#C8C8C8")
        spinner.center = loadingView!.center
        spinner.startAnimating()
        
        loadingView?.addSubview(spinner)
        view.addSubview(loadingView!)
    }
    
    func hideSpinner() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
}
