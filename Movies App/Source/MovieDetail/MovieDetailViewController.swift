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
    @IBOutlet weak var movieOriginalLanguageLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!    
    @IBOutlet weak var separatorView: NSLayoutConstraint!
    
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
        addGradient(view: gradientView, frame: gradientView.bounds, colors: [.clear, UIColor(named: "#252833")!])
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
        if let path = data.backdropPath { Tools.shared.setUpImage(path: path, ibImage: backdropPathImage) }
        if let path = data.posterPath { Tools.shared.setUpImage(path: path, ibImage: posterPathImage) }
        movieNameLabel.text = data.originalTitle ?? String()
        movieReleaseYearLabel.text = data.releaseDate ?? String()
        movieOriginalLanguageLabel.text = data.originalLanguage ?? String()
        movieRatingLabel.text = formatter(rating: data.voteAverage ?? 0.0)
        taglineLabel.text = data.tagline?.uppercased() ?? String()
        overviewLabel.text = data.overview ?? String()
        separatorView.constant = 0.2
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
    
}


