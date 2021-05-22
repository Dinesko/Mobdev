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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.backgroundColor = UIColor(named: "AccentColor")
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true

        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 69),
            activityIndicator.heightAnchor.constraint(equalToConstant: 69)
        ])
        return activityIndicator
    }()
    
    lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "No mooovies (((((("
        placeholderLabel.textColor = UIColor(named: "AccentColor")
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
        return placeholderLabel
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    var omdbURLItems: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.omdbapi.com"
        return urlComponents
    }
    
    var urlSession = URLSession(configuration: .default)
    var movies: [Movie] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeholderLabel.isHidden = false
        tableView.isHidden = true
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FilmTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        activityIndicator.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedId = movies[indexPath.row].imdbID
        
        getFullFilm(with: selectedId) { [weak self] movie in
            let controller = MovieDetailViewController.create(with: movie)
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func searchFilms(with name: String) {
        
        var omdbURLItems = omdbURLItems
        omdbURLItems.queryItems = [
            URLQueryItem(name: "apiKey", value: "847f01d8"),
            URLQueryItem(name: "s", value: name),
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let url = omdbURLItems.url else {
            return
        }
        
        activityIndicator.startAnimating()
        
        urlSession
            .dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
                
                print("response")
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                }
                
                if let error = error {
                    print(error.localizedDescription)
                    
                } else if let data = data {
                    do {
                        let serverResponse = try JSONDecoder().decode(Movies.self, from: data)
                        DispatchQueue.main.async {
                            self?.movies = serverResponse.items
                            self?.placeholderLabel.isHidden = !serverResponse.items.isEmpty
                            self?.tableView.isHidden = serverResponse.items.isEmpty
                            self?.tableView.reloadData()
                        }
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            .resume()
    }
    
    func getFullFilm(with id: String, completion: @escaping (Movie) -> Void) {
        
        var omdbURLItems = omdbURLItems
        omdbURLItems.queryItems = [
            URLQueryItem(name: "apiKey", value: "847f01d8"),
            URLQueryItem(name: "i", value: id),
        ]
        
        guard let url = omdbURLItems.url else {
            return
        }
        
        activityIndicator.startAnimating()
        
        urlSession
            .dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
                
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                }
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let data = data {
                    do {
                        let serverResponse = try JSONDecoder().decode(Movie.self, from: data)
                        DispatchQueue.main.async {
                            completion(serverResponse)
                        }
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            .resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as? FilmTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let enteredTextLowercased = searchController.searchBar.text?.lowercased(),
           enteredTextLowercased.count >= 3 {
            
            searchFilms(with: enteredTextLowercased)
        } else {
            setEmpty()
        }
    }
    
    func setEmpty() {
        movies = []
        tableView.reloadData()
        placeholderLabel.isHidden = false
        tableView.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        setEmpty()
    }
}
