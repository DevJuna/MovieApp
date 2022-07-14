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
    
    var movies = [Movie]()
    let customCellName: String = "MovieCell"
    let apiKey = "f0f843e7bb4dccaa26784708c2d59432"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView(tableView: moviesTableView, identifier: customCellName)
        setUpTableView()
        getPopularMovies()
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
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellName, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        cell.movieImage.image = UIImage(systemName: "hand.thumbsup.fill")
        cell.movieTitleLabel.text = movie.title ?? "Your favorite movie"
        
        return cell
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    // Row selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Has seleccionado la celda \(indexPath.row)")
    }
    
}

extension MovieListViewController {
    
    func getPopularMovies() {
        let service = CallService(baseUrl: "https://api.themoviedb.org/3/")
        service.getPopularMovieFrom(endPoint: "movie/popular")
        service.completionHandler { (popularMovie, status, message) in
            if status {
                guard let _popularMovies = popularMovie else { return }
                self.movies = _popularMovies.movies ?? []
                self.moviesTableView.reloadData()
            }
        }
    }
}
