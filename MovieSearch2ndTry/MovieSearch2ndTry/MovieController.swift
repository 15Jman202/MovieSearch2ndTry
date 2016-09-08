//
//  MovieController.swift
//  MovieSearch2ndTry
//
//  Created by Justin Carver on 9/8/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static let baseURL = NSURL(string: "http://api.themoviedb.org/3/search/movie?")
    
    static let imageURL = NSURL(string: "http://image.tmdb.org/t/p/w500")
    
    static func getMovies(searchTerm: String, completion: (movies: [Movie]?) -> Void) {
        
        guard let url = baseURL else { return }
    
        let urlParameters = ["api_key": "4cc920dab8b729a619647ccc4d191d5e", "query": "\(searchTerm)"]
        
        NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
            if error != nil {
                print(error?.localizedDescription)
                completion(movies: [])
                return
            }
            
            guard let data = data,
                JSONDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject],
                resultsArrayofDictionary = JSONDictionary["results"] as? [[String: AnyObject]]
                else { completion(movies: []); return }
            
            let MovieDictionary = resultsArrayofDictionary.flatMap({ Movie(dictionary: $0) })
            
            completion(movies: MovieDictionary)
        }
    }
    
    static func getImage(movie: Movie, completion: (poster: UIImage?) -> Void) {
        
        guard let url = imageURL?.URLByAppendingPathComponent("\(movie.imageEndPoint)") else { completion(poster: nil); return }
        
        ImageController.imageForURL(url.absoluteString) { (image) in
            if image == nil {
                completion(poster: nil)
                return
            }
            
            completion(poster: image)
        }
    }
}