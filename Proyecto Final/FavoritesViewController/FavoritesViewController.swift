//
//  FavoritesViewController.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 16/3/22.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var favorites = [Launch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        
        table.delegate = self
        table.dataSource = self
        
        table.register(ListTableViewCell.nib(), forCellReuseIdentifier: ListTableViewCell.identifier)
        
        getSavedFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        getSavedFavorites()
    }
    
    func getSavedFavorites() {
        let savedFavorites = getFavorites()
        self.favorites = savedFavorites
        
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        
        let launch = favorites[indexPath.row]

        cell.launch = launch
        cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.favorite = true
        
        cell.titleLabel.text = launch.name
        
        cell.buttonTapCallback = {
            self.favorites = getFavorites()
            self.table.deleteRows(at: [indexPath], with: .none)
        }
        
        if let desc = launch.details {
            cell.descriptionLabel.text = "\(desc.prefix(25))..."
        }
        
        let url = launch.links.patch.small
        
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    cell.myImageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let launch = favorites[indexPath.row]
        
        vc.launch = launch
        
        show(vc, sender: nil)
    }
    
}
