//
//  MovieDetailViewController.swift
//  Mobdev
//
//  Created by Denis on 17.04.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    static func create(with movie: Movie) -> MovieDetailViewController {
        
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        controller.movie = movie
        return controller
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie!
    var movieData: [Movie.FiledValue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieData = movie.generatedFieldValues
        posterImageView.layer.cornerRadius = 16
        posterImageView.image = movie.getPosterImage()
        tableView.register(UINib(nibName: "MovieDetailTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieDetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Film info"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell", for: indexPath) as? MovieDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let data = movieData[indexPath.row]
        cell.configure(data: data)
        
        return cell
    }
}
