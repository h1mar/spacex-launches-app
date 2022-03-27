//
//  ListTableViewCell.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 16/3/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    static let identifier = "ListTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ListTableViewCell", bundle: nil)
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var favoriteButton: UIButton!
    
    var launch: Launch?
    var favorite: Bool = false
    var buttonTapCallback: () -> ()  = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont(name: "Helvetica", size: 20)
        descriptionLabel.textColor = .systemGray
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(self.favoritoButtonTapped), for: .touchUpInside)
    }
    
    @objc func favoritoButtonTapped() {
                
        if self.favorite {
            // Remove from favorites
            removeFromFavorites(launch: launch)
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            self.favorite = false
        } else {
            // Add to favorites
            saveFavorite(launch: launch)
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            self.favorite = true
        }
        
        buttonTapCallback()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
