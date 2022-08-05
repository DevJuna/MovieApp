//
//  MovieDetailViewModel.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 05/07/2022.
//

import Foundation

struct MovieDetailViewModel {

    let title: String
    let backdropPath: String
    let releaseDate: String
    let voteAverage: Double
    let originalLanguage: String
    let posterPath: String
    let genres: [Genre]
    let tagline: String
    let overview: String
    let homepage: String

    //Dependency Injection (DI)
    init(movieDetail: MovieDetail) {
        self.title = movieDetail.title ?? String()
        self.backdropPath = movieDetail.backdropPath ?? String()
        self.releaseDate = movieDetail.releaseDate ?? String()
        self.voteAverage = movieDetail.voteAverage ?? 0.0
        self.originalLanguage = movieDetail.originalLanguage ?? String()
        self.posterPath = movieDetail.posterPath ?? String()
        self.genres = movieDetail.genres ?? []
        self.tagline = movieDetail.tagline ?? String()
        self.overview = movieDetail.overview ?? String()
        self.homepage = movieDetail.homepage ?? String()
    }
    
}
