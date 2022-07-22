//
//  Tools.swift
//  Movies App
//
//  Created by Juleanny Navas Moreno on 21/07/2022.
//

import Foundation
import UIKit
import Kingfisher


class Tools {
    
    public static let shared = Tools() //Singleton
    
    //MARK: SetUpImage
    func setUpImage(path: String, ibImage: UIImageView) {
        let urlBase = "https://image.tmdb.org/t/p/w500"
        
        let urlString = "\(urlBase)\(path)"
        let url = URL(string: urlString)
        ibImage.kf.indicatorType = .activity
        ibImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.5))])
    }
}
