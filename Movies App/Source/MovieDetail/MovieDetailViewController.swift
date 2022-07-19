//
//  MovieDetailViewController.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 05/07/2022.
//

import Foundation
import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropPathImage: UIImageView!
    @IBOutlet weak var posterPathImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var movieOriginalLanguageLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    
    let data: Movie
    
    init(data: Movie) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = data.title
        
        getMovieDetail()
    }
    
    func getMovieDetail() {
        let service = CallService(baseUrl: "https://api.themoviedb.org/3/movie/")
        guard let id = data.id else { return }
        service.getMovieDetailWith(movieId: "\(id)")
        service.movieDetailCompletionHandler { (movieDetail, status, message) in
            if status {
                guard let _movieDetail = movieDetail else { return }
                self.setUpView(data: _movieDetail)
            }
        }
    }
    
    func setUpView(data: MovieDetail) {
        if let path = data.backdropPath { setUpImage(path: path, ibImage: backdropPathImage) }
        if let path = data.posterPath { setUpImage(path: path, ibImage: posterPathImage) }
        movieNameLabel.text = data.originalTitle ?? String()
        movieReleaseYearLabel.text = data.releaseDate ?? String()
        movieOriginalLanguageLabel.text = data.originalLanguage ?? String()
        movieRatingLabel.text = "\(data.voteAverage ?? 0.0)"

    }
    
    func setUpImage(path: String, ibImage: UIImageView) {
        let urlBase = "https://image.tmdb.org/t/p/w500"
        
        let urlString = "\(urlBase)\(path)"
        let url = URL(string: urlString)
        ibImage.kf.indicatorType = .activity
        ibImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.5))])
        
    }
    
}
