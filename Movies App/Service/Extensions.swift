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

    func showToastWith(message: String) {
            let toastView = UIView(frame: CGRect(x: 20, y: view.frame.height - 120, width: view.frame.width - 40, height: 72))
            toastView.backgroundColor = UIColor(named: "#000000DE")
            toastView.alpha = 1.0
            toastView.layer.cornerRadius = 4
            toastView.clipsToBounds = true

            let toastLabel = UILabel(frame: CGRect(x: 12, y: 6, width: toastView.frame.width - 24, height: toastView.frame.height - 12))
            toastLabel.textAlignment = .left
            toastLabel.textColor = UIColor(named: "#FFFFFFDE")
            toastLabel.font = UIFont(name: "AvenirNext-Regular", size: 14.0)
            toastLabel.numberOfLines = 0
            toastLabel.text = message

            toastView.addSubview(toastLabel)
            self.view.addSubview(toastView)

            UIView.animate(withDuration: 2.0, delay: 6.0, options: .curveEaseInOut, animations: {
                toastView.alpha = 0.0
            }) { (isConpleted) in
                toastView.removeFromSuperview()
            }
        }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
