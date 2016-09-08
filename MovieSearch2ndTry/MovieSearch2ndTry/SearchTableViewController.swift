//
//  SearchTableViewController.swift
//  MovieSearch2ndTry
//
//  Created by Justin Carver on 9/8/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var Movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate = self
    }
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        SearchBar.resignFirstResponder()
        
        guard let searchterm = SearchBar.text where !searchterm.isEmpty else { print("Search Terms Cannot be empty"); return }
        
        MovieController.getMovies(searchterm) { (movies) in
            if let movies = movies {
                self.Movies = movies
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as? MovieTableViewCell
        let movie = Movies[indexPath.row]
            cell?.TitleLabel.text = movie.title
            cell?.DescriptionLabel.text = movie.description
            cell?.RatingLabel.text = "Rating: \(movie.rating)"
            
            MovieController.getImage(movie) { (poster) in
                if let poster = poster {
                    cell?.posterImage.image = poster
                    }
                }
        return cell ?? MovieTableViewCell()
    }
}
