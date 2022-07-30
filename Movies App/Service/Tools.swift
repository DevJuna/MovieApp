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
    
    //MARK: Date Formatter
    
    func formatter(date: String, from: String, to: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = from
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = to
        
        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        } else {
            return "There was an error decoding the string"
        }
    }
    
}

