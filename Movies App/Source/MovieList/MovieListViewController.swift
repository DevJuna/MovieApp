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
    let apiKey = "f0f843e7bb4dccaa26784708c2d59432"
    let apiRequestExample = "https://api.themoviedb.org/3/movie/550?api_key=f0f843e7bb4dccaa26784708c2d59432"
    let apiToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMGY4NDNlN2JiNGRjY2FhMjY3ODQ3MDhjMmQ1OTQzMiIsInN1YiI6IjYyY2NjZjM0ZTAwNGE2MDM0NmY2MmI4ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JL0ckNzS-C6mto5DKTLcEiw83B6ay7cQiGJ0vnt5HhQ"
    
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
