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
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var posterPathImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var movieGeneralInfoLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var MovieGenreLabel: UILabel!
    
    let movieData: Movie
    var data: MovieDetail?
    
    init(movieData: Movie) {
        self.movieData = movieData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieDetail()
        addGradient(view: gradientView, frame: gradientView.bounds, colors: [.clear, UIColor(named: "#252833")!])
    }
    
    func setUpNavigationItem() {
        guard let homePage = data?.homepage else { return }
        if !homePage.isEmpty {
            let rightItem = UIBarButtonItem()
            rightItem.image = UIImage(systemName: "square.and.arrow.up")
            navigationItem.rightBarButtonItem = rightItem
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        }
    }
    
    @objc func shareTapped() {
        guard let homePage = data?.homepage else { return }
        let vc = UIActivityViewController(activityItems: [homePage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func getMovieDetail() {
        let service = CallService(baseUrl: "https://api.themoviedb.org/3/movie/")
        guard let id = movieData.id else { return }
        service.getMovieDetailWith(movieId: "\(id)")
        service.movieDetailCompletionHandler { (movieDetail, status, message) in
            if status {
                guard let _movieDetail = movieDetail else { return }
                self.data = _movieDetail
                self.setUpView(data: _movieDetail)
                self.setUpNavigationItem()
            }
        }
    }
    
    func setUpView(data: MovieDetail) {
        if let path = data.backdropPath { Tools.shared.setUpImage(path: path, ibImage: backdropPathImage) }
        if let path = data.posterPath { Tools.shared.setUpImage(path: path, ibImage: posterPathImage) }
        movieNameLabel.text = data.originalTitle ?? String()
        if let date = data.releaseDate { movieReleaseYearLabel.text = Tools.shared.formatter(date: date, from: "yyyy-MM-dd", to: "MMM dd, yyyy") }
        if let language = data.originalLanguage, let runtime = data.runtime { movieGeneralInfoLabel.text = "\(language.capitalized)   •   \(runtime) mins" }
        movieRatingLabel.text = formatter(rating: data.voteAverage ?? 0.0)
        taglineLabel.text = data.tagline == nil || data.tagline == "" ? "SYNOPSIS" : data.tagline?.uppercased()
        overviewLabel.text = data.overview ?? String()
        getGenreList(data: data)
    }
    
    func formatter(rating: Double) -> String {
        switch rating {
        case 0..<3:
            return "Rating \(rating)   ⭐️"
        case 3..<5:
            return "Rating \(rating)   ⭐️⭐️"
        case 5..<7:
            return "Rating \(rating)   ⭐️⭐️⭐️"
        case 7..<9:
            return "Rating \(rating)   ⭐️⭐️⭐️⭐️"
        case 9...10:
            return "Rating \(rating)   ⭐️⭐️⭐️⭐️⭐️"
        default:
            return "No data"
        }
    }
    
    func addGradient(view: UIView, frame:CGRect, colors: [UIColor]) {
        view.addGradientLayer(frame: frame, colors: colors)
    }
    
    func getGenreList(data: MovieDetail) {
        var genresList = ""
        guard let genres = data.genres else { return }
        for genre in genres {
            genresList += "\(genre.name!) • "
        }
        genresList.removeLast(3)
        
        MovieGenreLabel.text = genresList
    }
    
}
