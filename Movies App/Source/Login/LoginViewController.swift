//
//  LoginViewController.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 09/08/2022.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var createAccountView: UIView!
    @IBOutlet weak var caEmailTextField: UITextField!
    @IBOutlet weak var caPasswordTextField: UITextField!
    @IBOutlet weak var caCorfirmPasswordTextField: UITextField!
    @IBOutlet weak var caButton: UIButton!
    @IBOutlet weak var siEmailTextField: UITextField!
    @IBOutlet weak var siPasswordTextField: UITextField!
    @IBOutlet weak var siButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

    func setUpView() {
        signInView.isHidden = false
        createAccountView.isHidden = true
        caButton.layer.cornerRadius = 6.0
        caButton.layer.borderWidth = 1.0
        caButton.layer.borderColor = UIColor.lightGray.cgColor
        siButton.layer.cornerRadius = 6.0
        siButton.layer.borderWidth = 1.0
        siButton.layer.borderColor = UIColor.lightGray.cgColor

    }

    @IBAction func signInAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            signInView.isHidden = false
            createAccountView.isHidden = true
        } else {
            signInView.isHidden = true
            createAccountView.isHidden = false
        }
    }

    @IBAction func validateSignInTextFieldsChanged(_ sender: UITextField) {
        let email = siEmailTextField.text ?? ""
        let password = siPasswordTextField.text ?? ""
        if email.count > 0 && password.count > 0 {
            siButton.isEnabled = true
        } else {
            siButton.isEnabled = true
        }
    }

    @IBAction func validateCreateAccountTextFieldsChanged(_ sender: UITextField) {
        let email = caEmailTextField.text ?? ""
        let password = caPasswordTextField.text ?? ""
        let confirmPassword = caCorfirmPasswordTextField.text ?? ""
        if email.count > 0 && password.count > 0 && confirmPassword.count > 0 {
            caButton.isEnabled = true
        } else {
            caButton.isEnabled = true
        }
    }

    @IBAction func caActionButton(_ sender: UIButton) {

    }

    @IBAction func siActionButton(_ sender: UIButton) {
        
    }

    func validateEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }

    func corfirmPassword(password1: String, password2: String) -> Bool {
        return password1 == password2
    }

    func validatePasswordLong(password1: String) -> Bool {
        return password1.count >= 8
    }
}
