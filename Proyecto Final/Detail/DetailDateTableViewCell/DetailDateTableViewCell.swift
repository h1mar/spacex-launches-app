//
//  DetailDateTableViewCell.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 20/3/22.
//

import UIKit

class DetailDateTableViewCell: UITableViewCell {
    
    static let identifier = "DetailDateTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailDateTableViewCell", bundle: nil)
    }
    
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.label.textAlignment = .left
        self.label.font = UIFont(name: "Helvetica", size: 15)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
