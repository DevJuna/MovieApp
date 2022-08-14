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
    @IBOutlet weak var caEmailImage: UIImageView!
    @IBOutlet weak var caEmailLabel: UILabel!
    @IBOutlet weak var caPasswordTextField: UITextField!
    @IBOutlet weak var caPasswordImage: UIImageView!
    @IBOutlet weak var caPasswordLabel: UILabel!
    @IBOutlet weak var caCorfirmPasswordTextField: UITextField!
    @IBOutlet weak var caConfirmPasswordImage: UIImageView!
    @IBOutlet weak var caConfirmPasswordLabel: UILabel!
    @IBOutlet weak var caButton: UIButton!
    @IBOutlet weak var siEmailTextField: UITextField!
    @IBOutlet weak var siEmailImage: UIImageView!
    @IBOutlet weak var siEmailLabel: UILabel!
    @IBOutlet weak var siPasswordTextField: UITextField!
    @IBOutlet weak var siPasswordImage: UIImageView!
    @IBOutlet weak var siPasswordLabel: UILabel!
    @IBOutlet weak var siButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

    func setUpView() {
        signInView.isHidden = false
        createAccountView.isHidden = true

        caEmailImage.image = UIImage(systemName: "mail.fill")
        caEmailLabel.text = "Enter a valid email"
        caPasswordImage.image = UIImage(systemName: "key.fill")
        caPasswordLabel.text = "The password must contain 8 to 20 characters, including an uppercase letter, a lowercase letter and a number"
        caConfirmPasswordImage.image = UIImage(systemName: "key.fill")
        caConfirmPasswordLabel.text = "Confirm your password"


        caButton.layer.cornerRadius = 6.0
        caButton.layer.borderWidth = 1.0
        caButton.layer.borderColor = UIColor.lightGray.cgColor

        siEmailImage.image = UIImage(systemName: "mail.fill")
        siEmailLabel.text = "Enter your email"
        siPasswordImage.image = UIImage(systemName: "key.fill")
        siPasswordLabel.text = "Enter your password"

        siButton.layer.cornerRadius = 6.0
        siButton.layer.borderWidth = 1.0
        siButton.layer.borderColor = UIColor.lightGray.cgColor

    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            signInView.isHidden = false
            createAccountView.isHidden = true
        } else {
            signInView.isHidden = true
            createAccountView.isHidden = false
        }
    }

    @IBAction func validateCreateAccountTextFieldsChanged(_ sender: UITextField) {
        let email = caEmailTextField.text ?? ""
        let password = caPasswordTextField.text ?? ""
        let confirmPassword = caCorfirmPasswordTextField.text ?? ""

        setUpEmailImageAndLabel(email: email, image: caEmailImage, label: caEmailLabel, textInfo: "Enter a valid email")


        if email.count > 0 && password.count > 0 && confirmPassword.count > 0 {
            caButton.isEnabled = true
        } else {
            caButton.isEnabled = true
        }
    }

    @IBAction func caActionButton(_ sender: UIButton) {

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



    @IBAction func siActionButton(_ sender: UIButton) {
        
    }

    func validateEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }

    func setUpEmailImageAndLabel(email: String, image: UIImageView, label: UILabel, textInfo: String) {
        if email.isEmpty {
            image.image = UIImage(systemName: "mail.fill")
            image.tintColor = UIColor(named: "#AAAAAA")
        } else {
            if validateEmail(email: email) {
                //Cambia la imagen a check verde y el texto ""
                image.image = UIImage(systemName: "checkmark.circle.fill")
                image.tintColor = UIColor(named: "#40B617")
                label.text = ""
            } else {
                //Cambia image a x rojo y el texto
                image.image = UIImage(systemName: "x.circle.fill")
                image.tintColor = UIColor(named: "#BE1D0C")
                label.text = textInfo
            }
        }
    }

    func corfirmPassword(password1: String, password2: String) -> Bool {
        return password1 == password2
    }

    func validatePasswordLong(password1: String) -> Bool {
        return password1.count >= 8
    }
}
