//
//  CallService.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 13/07/2022.
//

import Foundation
import Alamofire

class CallService {
    
    fileprivate var baseUrl = ""
    typealias popularMoviesCallBack = (_ popularMovies: PopularMovie?, _ status: Bool, _ message: String) -> Void
    var callBack: popularMoviesCallBack?
    
    //https://api.themoviedb.org/3/movie/popular?api_key=f0f843e7bb4dccaa26784708c2d59432
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    //MARK: GetPopularMovie
    func getPopularMovieFrom(endPoint: String) {
        AF.request(self.baseUrl + endPoint + "?api_key=f0f843e7bb4dccaa26784708c2d59432", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "")
                return
            }
            do {
                let popularMovies = try JSONDecoder().decode(PopularMovie.self, from: data)
                self.callBack?(popularMovies, true, "")
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func completionHandler(callBack: @escaping popularMoviesCallBack) {
        self.callBack = callBack
    }
    
}
