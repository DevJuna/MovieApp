//
//  MovieDetailViewController.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 05/07/2022.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
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
//        print(data)
    }
    
}
