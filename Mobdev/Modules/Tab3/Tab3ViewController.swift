//
//  Tab3ViewController.swift
//  Mobdev
//
//  Created by Denis on 07.03.2021.
//

import UIKit

class Tab3ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FilmTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        movies = getMovies()
        tableView.reloadData()
    }
    
    func getMovies() -> [Movie] {
        
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
        
        let selectedId = movies[indexPath.row].imdbID
        
        if let selectedMovie = getMovie(with: selectedId) {
            let controller = MovieDetailViewController.create(with: selectedMovie)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as? FilmTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}
