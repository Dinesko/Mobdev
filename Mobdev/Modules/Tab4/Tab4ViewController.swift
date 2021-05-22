//
//  Tab4ViewController.swift
//  Mobdev
//
//  Created by Denis on 09.05.2021.
//

import UIKit
import SDWebImage

class Tab4ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    var urlSession = URLSession(configuration: .default)
    var currentInstagramImages: [PixabayImage] = []
    
    var pixabayURLItems: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pixabay.com"
        urlComponents.path = "/api"
        return urlComponents
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        getImages()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        activityIndicator.layer.cornerRadius = 10
    }
    
    func setupCollectionView() {
        
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(UICollectionViewLayout.createInstagramCollectionViewLayout(), animated: false)
    }
    
    func getImages() {
        
        var omdbURLItems = pixabayURLItems
        omdbURLItems.queryItems = [
            URLQueryItem(name: "key", value: "19193969-87191e5db266905fe8936d565"),
            URLQueryItem(name: "q", value: "small+animals"),
            URLQueryItem(name: "image_type", value: "photo"),
            URLQueryItem(name: "per_page", value: "18")
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
                    
                } else if let data = data {
                    do {
                        let serverResponse = try JSONDecoder().decode(PixabayImages.self, from: data)
                        DispatchQueue.main.async {
                            self?.currentInstagramImages = serverResponse.hits
                            self?.collectionView.reloadData()
                        }
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            .resume()
    }
}

extension Tab4ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return currentInstagramImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let instagramImage = currentInstagramImages[indexPath.row]
        cell.photoImageView.sd_setImage(with: URL(string: instagramImage.webformatURL ?? ""),
                                        placeholderImage: UIImage(systemName: "ant.fill")?
                                            .withTintColor(UIColor(named: "AccentColor") ?? .red,
                                                           renderingMode: .alwaysTemplate))
        return cell
    }
}
