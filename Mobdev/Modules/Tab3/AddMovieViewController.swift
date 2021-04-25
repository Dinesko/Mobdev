//
//  AddMovieViewController.swift
//  Mobdev
//
//  Created by Denis on 25.04.2021.
//

import UIKit

class AddMovieViewController: UIViewController {
    
    static func create(onAdd: ((Movie) -> Void)?) -> AddMovieViewController {
        
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddMovieViewController") as! AddMovieViewController
        controller.onAdd = onAdd
        return controller
    }
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var onAdd: ((Movie) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addButton.layer.cornerRadius = 10
    }
    
    @IBAction func didPressAdd(_ sender: UIButton) {
        
        var title = titleField.text ?? ""
        var type = typeField.text ?? ""
        var year = yearField.text ?? ""
        
        if title.isEmpty {
            title = "No specified."
        }
        
        if type.isEmpty {
            type = "No specified."
        }
        
        if year.isEmpty {
            year = "No specified."
        }
        
        let movie = Movie(title: title, year: year, imdbID: UUID().uuidString, type: type, poster: "", rated: nil, released: nil, production: nil, runtime: nil, genre: nil, director: nil, writer: nil, actors: nil, plot: nil, language: nil, country: nil, awards: nil, imdbRating: nil, imdbVotes: nil)
        onAdd?(movie)
        navigationController?.popViewController(animated: true)
    }
}
