//
//  MovieListViewModel.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 05/07/2022.
//

import Foundation

struct MovieListViewModel {
    
    let title: String
    let posterPath: String
    let id: Int
    
    //Dependency Injection (DI)
    init(movie: Movie) {
        self.title = movie.title ?? String()
        self.posterPath = movie.posterPath ?? String()
        self.id = movie.id ?? 0
    }
}
