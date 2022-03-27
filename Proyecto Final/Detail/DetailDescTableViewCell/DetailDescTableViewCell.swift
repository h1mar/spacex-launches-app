//
//  DetailDescTableViewCell.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 20/3/22.
//

import UIKit

class DetailDescTableViewCell: UITableViewCell {
    static let identifier = "DetailDescTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailDescTableViewCell", bundle: nil)
    }
    
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
