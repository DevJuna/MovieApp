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
        
        getPopularMovies()
        registerTableView(tableView: moviesTableView, identifier: customCellName)
        setUpTableView()
    }
    
    //Hide NavigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        self.moviesTableView.rowHeight = 90.0
    }
    
    // Call Service
    func getPopularMovies() {
        self.showSpinner()
        let service = CallService(baseUrl: "https://api.themoviedb.org/3/movie/")
        service.getPopularMovieFrom(endPoint: "popular")
        service.popularMoviesCompletionHandler { (popularMovie, status, message) in
            if status {
                guard let _popularMovies = popularMovie else { return }
                self.movies = _popularMovies.movies ?? []
                if self.movies.isEmpty {
                    self.showAlertControllerWith(title: "Error", message: "We could not retrieve the data, please try again later")
                } else {
                    self.moviesTableView.reloadData()
                }
                self.hideSpinner()
            } else {
                // Alert controller para mostrar error
                self.showAlertControllerWith(title: "Error", message: message)
                self.hideSpinner()
            }
        }
    }
    
    //MARK: AlertController (Error message)
    func showAlertControllerWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let reloadActionButton = UIAlertAction(title: "Reload", style: .default) { (_) in
            self.getPopularMovies()
        }
        alertController.addAction(reloadActionButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellName, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        if let path = movie.posterPath { Tools.shared.setUpImage(path: path, ibImage: cell.movieImage) }
        cell.movieTitleLabel.text = movie.title ?? "Your favorite movie"
        
        return cell
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    // Row selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Has seleccionado la celda \(indexPath.row)")
        let movieData = movies[indexPath.row]
        let movieDetail = MovieDetailViewController(movieData: movieData)
        self.navigationController?.pushViewController(movieDetail, animated: true)
    }
    
}

