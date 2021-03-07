//
//  FilmTableViewCell.swift
//  MobileDev
//
//  Created by Denis on 11.02.2021.
//

import UIKit

final class FilmTableViewCell: UITableViewCell {
        
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        yearLabel.isHidden = false
        typeLabel.isHidden = false
    }
    
    func configure(with model: Movie) {
        
        nameLabel.text = model.title
        posterImageView.image = model.getPosterImage()
        
        if model.year.isEmpty {
            yearLabel.isHidden = true
        } else {
            yearLabel.text = model.year
        }
        
        if model.type.isEmpty {
            typeLabel.isHidden = true
        } else {
            typeLabel.text = model.type
        }
    }
}
