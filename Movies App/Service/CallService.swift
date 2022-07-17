//
//  CallService.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 13/07/2022.
//

import Foundation
import Alamofire

class CallService {
    
    private var apiKey = "?api_key=f0f843e7bb4dccaa26784708c2d59432"
    fileprivate var baseUrl = ""
    
    typealias popularMoviesCallBack = (_ popularMovies: PopularMovie?, _ status: Bool, _ message: String) -> Void
    var popularMoviesCallBack: popularMoviesCallBack?
    
    typealias movieDetailCallBack = (_ movieDetail: MovieDetail?, _ status: Bool, _ message: String) -> Void
    var movieDetailCallBack: movieDetailCallBack?
    
    //https://api.themoviedb.org/3/movie/popular?api_key=f0f843e7bb4dccaa26784708c2d59432
    //https://api.themoviedb.org/3/movie/{movie_id}?api_key=f0f843e7bb4dccaa26784708c2d59432
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    //MARK: GetPopularMovie
    func getPopularMovieFrom(endPoint: String) {
        let url = "\(self.baseUrl)\(endPoint)\(apiKey)"
        print("URL: \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            guard let data = responseData.data else {
                self.popularMoviesCallBack?(nil, false, "")
                return
            }
            do {
                let popularMovies = try JSONDecoder().decode(PopularMovie.self, from: data)
                self.popularMoviesCallBack?(popularMovies, true, "")
//                print(popularMovies)
            } catch {
                self.popularMoviesCallBack?(nil, false, error.localizedDescription)
                print("ERROR DECODING: \(error.localizedDescription)")
            }
        }
    }
    
    func popularMoviesCompletionHandler(callBack: @escaping popularMoviesCallBack) {
        self.popularMoviesCallBack = callBack
    }
   
    
    //MARK: GetMovieDetail
    func getMovieDetailWith(movieId: String) {
        let url = "\(self.baseUrl)\(movieId)\(apiKey)"
        print("URL: \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            guard let data = responseData.data else {
                self.movieDetailCallBack?(nil, false, "")
                return
            }
            do {
                let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                self.movieDetailCallBack?(movieDetail, true, "")
                print(movieDetail)
            } catch {
                self.movieDetailCallBack?(nil, false, error.localizedDescription)
                print("ERROR DECODING: \(error.localizedDescription)")
            }
        }
    }
    
    func movieDetailCompletionHandler(callBack: @escaping movieDetailCallBack) {
        self.movieDetailCallBack = callBack
    }
    
}
