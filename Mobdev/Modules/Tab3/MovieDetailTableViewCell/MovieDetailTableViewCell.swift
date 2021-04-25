//
//  MovieDetailTableViewCell.swift
//  Mobdev
//
//  Created by Denis on 17.04.2021.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    public func configure(data: Movie.FiledValue) {
        
        fieldLabel.text = data.field
        valueLabel.text = data.value
    }
}
