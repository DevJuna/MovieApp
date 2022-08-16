//
//  LoginViewController.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 09/08/2022.
//

import Foundation
import UIKit
//import FirebaseAuth - TO-DO

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
    @IBOutlet weak var caConfirmPasswordTextField: UITextField!
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

    var isEnabledCAButton = false
    var isEnabledSIButton = false

    private var caEmail: String = ""
    private var caPassword: String = ""
    private var caConfirmPassword: String = ""

    let validEmail = "Enter a valid email"
    let formatPassword = "The password must contain 8 to 20 characters, including an uppercase letter, a lowercase letter and a number"
    let confirmPassword = "Confirm your password"
    let enterEmail = "Enter your email"
    let enterPassword = "Enter your password"
    let empty = String()


    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

    func setUpView() {
        signInView.isHidden = false
        createAccountView.isHidden = true

        clearCreateAccount()
        caButton.layer.cornerRadius = 6.0
        caButton.layer.borderWidth = 1.0
        caButton.layer.borderColor = UIColor.lightGray.cgColor

        clearSignIn()
        siButton.layer.cornerRadius = 6.0
        siButton.layer.borderWidth = 1.0
        siButton.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            clearCreateAccount()
            signInView.isHidden = false
            createAccountView.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            clearSignIn()
            signInView.isHidden = true
            createAccountView.isHidden = false
        }
    }

    func clearCreateAccount() {
        caEmailTextField.text = empty
        caPasswordTextField.text = empty
        caConfirmPasswordTextField.text = empty

        caEmailImage.image = UIImage(systemName: "mail.fill")
        caEmailImage.tintColor = UIColor(named: "#AAAAAA")
        caEmailLabel.text = validEmail
        caPasswordImage.image = UIImage(systemName: "key.fill")
        caPasswordImage.tintColor = UIColor(named: "#AAAAAA")
        caPasswordLabel.text = formatPassword
        caConfirmPasswordImage.image = UIImage(systemName: "key.fill")
        caConfirmPasswordImage.tintColor = UIColor(named: "#AAAAAA")
        caConfirmPasswordLabel.text = confirmPassword
    }

    func clearSignIn() {
        siEmailTextField.text = empty
        siPasswordTextField.text = empty

        siEmailImage.image = UIImage(systemName: "mail.fill")
        siEmailImage.tintColor = UIColor(named: "#AAAAAA")
        siEmailLabel.text = enterEmail
        siPasswordImage.image = UIImage(systemName: "key.fill")
        siPasswordImage.tintColor = UIColor(named: "#AAAAAA")
        siPasswordLabel.text = enterPassword
    }


    @IBAction func validateCreateAccountTextFieldsChanged(_ sender: UITextField) {
        caEmail = caEmailTextField.text ?? empty
        caPassword = caPasswordTextField.text ?? empty
        caConfirmPassword = caConfirmPasswordTextField.text ?? empty

        setUpEmailImageAndLabel(email: caEmail, image: caEmailImage, label: caEmailLabel, textInfo: validEmail)
        setUpPasswordImageAndLabel(password: caPassword, image: caPasswordImage, label: caPasswordLabel, textInfo: formatPassword)
        confirmPassword(password1: caPassword, password2: caConfirmPassword)
        caButton.isEnabled = isEnabledCAButton
    }

    @IBAction func caActionButton(_ sender: UIButton) {
//        Auth.auth().createUser(withEmail: caEmail, password: caPassword) { (result, error) in
            if true /* let result = result, error == nil */ { // - TO-DO
                let vc = MovieListViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                //Ha ocurrido un error al crear el User
                let error = /* error?.localizedDescription ?? */ "An error has ocurred, please try again" // - TO-DO
                self.showToastWith(message: error)
            }
//        }
    }


    @IBAction func validateSignInTextFieldsChanged(_ sender: UITextField) {
        let email = siEmailTextField.text ?? empty
        let password = siPasswordTextField.text ?? empty

        setUpEmailImageAndLabel(email: email, image: siEmailImage, label: siEmailLabel, textInfo: enterEmail)
        setUpPasswordImageAndLabel(password: password, image: siPasswordImage, label: siPasswordLabel, textInfo: enterPassword)
        siButton.isEnabled = isEnabledSIButton
    }

    @IBAction func siActionButton(_ sender: UIButton) {

    }


    func isValid(data: String, regex: String) -> Bool {
        let predicete = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicete.evaluate(with: data)
    }

    func setUpEmailImageAndLabel(email: String, image: UIImageView, label: UILabel, textInfo: String) {
        if email.isEmpty {
            image.image = UIImage(systemName: "mail.fill")
            image.tintColor = UIColor(named: "#AAAAAA")
            label.text = textInfo
            isEnabledCAButton = false
            isEnabledSIButton = false
        } else {
            if isValid(data: email, regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}") {
                image.image = UIImage(systemName: "checkmark.circle.fill")
                image.tintColor = UIColor(named: "#40B617")
                label.text = empty
                isEnabledCAButton = true
                isEnabledSIButton = true
            } else {
                image.image = UIImage(systemName: "x.circle.fill")
                image.tintColor = UIColor(named: "#BE1D0C")
                label.text = textInfo
                isEnabledCAButton = false
                isEnabledSIButton = false
            }
        }
    }

    func setUpPasswordImageAndLabel(password: String, image: UIImageView, label: UILabel, textInfo: String) {
        if password.isEmpty {
            image.image = UIImage(systemName: "key.fill")
            image.tintColor = UIColor(named: "#AAAAAA")
            label.text = textInfo
            isEnabledCAButton = false
            isEnabledSIButton = false
        } else {
            if isValid(data: password, regex: "^(?=.[A-Z])(?=.[0-9])(?=.*[a-z]).{8,20}$") {
                image.image = UIImage(systemName: "checkmark.circle.fill")
                image.tintColor = UIColor(named: "#40B617")
                label.text = empty
                isEnabledCAButton = isEnabledCAButton && true
                isEnabledSIButton = isEnabledSIButton && true
            } else {
                image.image = UIImage(systemName: "x.circle.fill")
                image.tintColor = UIColor(named: "#BE1D0C")
                label.text = textInfo
                isEnabledCAButton = false
                isEnabledSIButton = false
            }
        }
    }

    func confirmPassword(password1: String, password2: String) {
        if password2.isEmpty {
            caConfirmPasswordImage.image = UIImage(systemName: "key.fill")
            caConfirmPasswordImage.tintColor = UIColor(named: "#AAAAAA")
            isEnabledCAButton = false
        } else {
            if password1 == password2 {
                caConfirmPasswordImage.image = UIImage(systemName: "checkmark.circle.fill")
                caConfirmPasswordImage.tintColor = UIColor(named: "#40B617")
                caConfirmPasswordLabel.text = empty
                isEnabledCAButton = isEnabledSIButton && true
            } else {
                caConfirmPasswordImage.image = UIImage(systemName: "x.circle.fill")
                caConfirmPasswordImage.tintColor = UIColor(named: "#BE1D0C")
                caConfirmPasswordLabel.text = confirmPassword
                isEnabledCAButton = false
            }
        }
    }

}
