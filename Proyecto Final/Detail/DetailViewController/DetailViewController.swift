//
//  DetalleViewController.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 18/3/22.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var table: UITableView!
    
    var launch: Launch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        title = launch?.name
        
        table.register(DetailImageTableViewCell.nib(), forCellReuseIdentifier: DetailImageTableViewCell.identifier)
        
        table.register(DetailDateTableViewCell.nib(), forCellReuseIdentifier: DetailDateTableViewCell.identifier)
        
        table.register(DetailDescTableViewCell.nib(), forCellReuseIdentifier: DetailDescTableViewCell.identifier)
        
        table.register(DetailLinkTableViewCell.nib(), forCellReuseIdentifier: DetailLinkTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let launch = launch else {
            return UITableViewCell()
        }
        
        
        switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageTableViewCell.identifier, for: indexPath) as! DetailImageTableViewCell
                
                let url = launch.links.flickr.original[0]
                cell.configure(url: url)
                return cell
            
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailDateTableViewCell.identifier, for: indexPath) as! DetailDateTableViewCell
                let date = NSDate(timeIntervalSince1970: Double(launch.date_unix))
                
                cell.label.text = "Date: \(date)"
                return cell
            
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailDescTableViewCell.identifier, for: indexPath) as! DetailDescTableViewCell
                cell.label.text = launch.details
                return cell
            
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailLinkTableViewCell.identifier, for: indexPath) as! DetailLinkTableViewCell
                cell.url = launch.links.wikipedia
                cell.button.setTitle("Wikipedia", for: .normal)
                return cell
            
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailLinkTableViewCell.identifier, for: indexPath) as! DetailLinkTableViewCell
                cell.url = launch.links.webcast
                cell.button.setTitle("Video", for: .normal)
                return cell
            
            default:
                return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 2:
            return UITableView.automaticDimension
        default:
            return 50
        }
    }
    
}
