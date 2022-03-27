//
//  DetailImageTableViewCell.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 20/3/22.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {
    
    static let identifier = "DetailImageTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailImageTableViewCell", bundle: nil)
    }
    
    @IBOutlet var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.myImageView.contentMode = .scaleAspectFill
    }
    
    func configure(url: String) {
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.myImageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
