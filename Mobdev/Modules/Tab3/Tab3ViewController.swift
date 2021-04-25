//
//  Tab3ViewController.swift
//  Mobdev
//
//  Created by Denis on 07.03.2021.
//

import UIKit

class Tab3ViewController: UIViewController,
                          UITableViewDelegate,
                          UITableViewDataSource,
                          UISearchResultsUpdating,
                          UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    var searchController: UISearchController!
    var moviesInSearch: [Movie] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FilmTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        movies = getAllMovies()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func getAllMovies() -> [Movie] {
        
        do {
            if let path = Bundle.main.path(forResource: "MoviesList", ofType: "txt"),
               let jsonData = try String(contentsOfFile: path, encoding: String.Encoding.utf8).data(using: .utf8) {
                
                let decodedData = try JSONDecoder().decode(Movies.self, from: jsonData)
                return decodedData.items
            }
        } catch {
            print("Error: ", error.localizedDescription)
        }
        
        return []
    }
    
    func getMovie(with id: String) -> Movie? {
        
        guard !id.isEmpty else {
            return nil
        }
        
        do {
            if let path = Bundle.main.path(forResource: id, ofType: "txt"),
               let jsonData = try String(contentsOfFile: path, encoding: String.Encoding.utf8).data(using: .utf8) {
                
                let decodedData = try JSONDecoder().decode(Movie.self, from: jsonData)
                return decodedData
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedId: String
        
        if isSearching {
            selectedId = moviesInSearch[indexPath.row].imdbID
        } else {
            selectedId = movies[indexPath.row].imdbID
        }
        
        if let selectedMovie = getMovie(with: selectedId) {
            let controller = MovieDetailViewController.create(with: selectedMovie)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return moviesInSearch.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as? FilmTableViewCell else {
            return UITableViewCell()
        }
        
        let movie: Movie
        if isSearching {
            movie = moviesInSearch[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if isSearching {
                let movieToDelete = moviesInSearch.remove(at: indexPath.row)
                movies.removeAll { movie in
                    return movie.imdbID == movieToDelete.imdbID
                }
            } else {
                movies.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func didPressAdd(_ sender: UIBarButtonItem) {
        
        let controller = AddMovieViewController.create { movie in
            
            self.movies.append(movie)
            self.tableView.reloadData()
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let enteredTextLowercased = searchController.searchBar.text?.lowercased(),
           !enteredTextLowercased.isEmpty {
            
            moviesInSearch = movies.filter { movie in
                movie.title.lowercased().contains(enteredTextLowercased)
            }
            isSearching = true
            tableView.reloadData()
        } else {
            
            isSearching = false
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        tableView.reloadData()
    }
}
