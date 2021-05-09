//
//  Tab4ViewController.swift
//  Mobdev
//
//  Created by Denis on 09.05.2021.
//

import UIKit

class Tab4ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagePicker: CustomImagePicker!
    var currentInstagramImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupImagePicker()
        setupCollectionView()
    }
    
    func setupImagePicker() {
        
        imagePicker = CustomImagePicker(presentationController: self, delegate: self)
    }
    
    func setupCollectionView() {
        
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(UICollectionViewLayout.createInstagramCollectionViewLayout(), animated: false)
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        
        imagePicker.present()
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
        
        cell.photoImageView.image = currentInstagramImages[indexPath.row]
        return cell
    }
}

extension Tab4ViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        
        if let newImage = image {
            
            currentInstagramImages.append(newImage)
            collectionView.insertItems(at: [IndexPath(row: currentInstagramImages.count - 1, section: 0)])
//            collectionView.reloadData()
        }
    }
}
