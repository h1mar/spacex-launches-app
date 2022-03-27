//
//  DetailLinkTableViewCell.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 20/3/22.
//

import UIKit

class DetailLinkTableViewCell: UITableViewCell {
    
    static let identifier = "DetailLinkTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailLinkTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button: UIButton!
    
    var url: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.addTarget(self, action: #selector(self.buttonTap), for: .touchUpInside)
    }
    
    @objc func buttonTap() {
        guard let url = url else {
            return
        }
        
        
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
