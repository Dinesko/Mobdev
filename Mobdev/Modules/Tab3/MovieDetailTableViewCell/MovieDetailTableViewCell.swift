//
//  MovieDetailTableViewCell.swift
//  Mobdev
//
//  Created by Denys Danyliuk on 17.04.2021.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    func configure(field: String, value: String) {
        
        fieldLabel.text = field
        valueLabel.text = value
    }
}
