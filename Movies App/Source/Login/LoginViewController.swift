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


    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

    func setUpView() {
        signInView.isHidden = false
        createAccountView.isHidden = true
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
}
