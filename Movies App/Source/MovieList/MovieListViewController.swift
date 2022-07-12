//
//  MovieListViewController.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 05/07/2022.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    let customCellName: String = "MovieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView(tableView: moviesTableView, identifier: customCellName)
        setUpTableView()
    }
    
    // Registrando la TableView
    func registerTableView(tableView: UITableView, identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    // movieTableView = IBOulet. es de tipo UITableView, le estoy indicando que las ext dataSource y delegate las voy a manejar yo (voy a programar su funcionamiento)
    func setUpTableView() {
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
    }
    
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellName, for: indexPath) as! MovieCell
        
        cell.movieImage.image = UIImage(systemName: "hand.thumbsup.fill")
        cell.movieTitleLabel.text = "Your favorite movie"
        
        return cell
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    // Row selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Has seleccionado la celda \(indexPath.row)")
    }
    
}
