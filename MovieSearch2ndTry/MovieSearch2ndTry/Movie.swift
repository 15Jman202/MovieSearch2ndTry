//
//  Movie.swift
//  MovieSearch2ndTry
//
//  Created by Justin Carver on 9/8/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import Foundation

class Movie {
    
    private let kTitle = "title"
    private let kImageEndPoint = "poster_path"
    private let kRating = "vote_average"
    private let kDescription = "overview"
    
    var title: String
    var rating: Double
    var description: String
    var imageEndPoint: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let title = dictionary[kTitle] as? String,
            rating = dictionary[kRating] as? Double,
            description = dictionary[kDescription] as? String,
            imageEndPoint = dictionary[kImageEndPoint] as? String
            
            else { return nil }
        
        self.title = title
        self.description = description
        self.rating = rating
        self.imageEndPoint = imageEndPoint
    }
}