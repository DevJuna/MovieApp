//
//  LoginViewController.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 05/07/2022.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        goToMovieList()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        goToMovieList()
    }
    
    func goToMovieList() {
        let movieList = MovieListViewController()
        self.navigationController?.pushViewController(movieList, animated: true)
    }
}
