//
//  ListViewController.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 16/3/22.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var table: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var launches = [Launch]()
    var filteredLaunches: [Launch] = []
    var favorites = [Launch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Launches"
        
        orderButton()
        
        fetchLaunches()
        
        table.delegate = self
        table.dataSource = self
        searchController.searchBar.delegate = self
        
        table.register(ListTableViewCell.nib(), forCellReuseIdentifier: ListTableViewCell.identifier)
        
        navigationItem.searchController = searchController
    }
    
    @objc func filterButtonTapped() {
        print("tap")
    }
    
    func orderButton() {
        
        let accionAscendent = UIAction(title: "Ascendent") { _ in
            self.filteredLaunches = self.launches.sorted { l1, l2 in
                "\(l1.name)" <= "\(l2.name)"
            }
            self.table.reloadData()
        }
        let accionDescendent = UIAction(title: "Descendent") { _ in
            self.filteredLaunches = self.launches.sorted { l1, l2 in
                "\(l1.name)" > "\(l2.name)"
            }
            self.table.reloadData()
        }
        let accionNone = UIAction(title: "None") { _ in
            self.filteredLaunches = self.launches
            self.table.reloadData()
        }
        
        let button = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"),
                                     primaryAction: nil,
                                     menu: UIMenu(children: [accionAscendent, accionDescendent, accionNone]))
        navigationItem.rightBarButtonItem = button
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            filteredLaunches = launches.filter {$0.name.lowercased().contains(searchText.lowercased())}
        } else {
            filteredLaunches = launches
        }
        self.table.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredLaunches = launches
        self.table.reloadData()
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
    
    func fetchLaunches() {
        let headers = ["content-type": "application/json"]
        let parameters = ["query": ["flight_number": ["$gt": 50], "upcoming": false], "options": ["limit": 20, "sort": ["flight_number": "asc"]]] as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        // Create post request
        let url = URL(string: "https://api.spacexdata.com/v5/launches/query")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = postData
        request.allHTTPHeaderFields = headers
        
        // Fetch data
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Validation
            guard let data = data, error == nil else {
                print("error")
                return
            }
            
            // Convert data to models
            var json: ApiRoot?
            
            do {
                json = try JSONDecoder().decode(ApiRoot.self, from: data)
            } catch {
                print("error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            let entries = result.docs
            
            self.launches = entries
            self.filteredLaunches = entries
            
            // Update table
            DispatchQueue.main.async {
                self.table.reloadData()
                
            }
            
        }.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        
        let launch = filteredLaunches[indexPath.row]
        cell.launch = launch
        
        // If it's saved as favorite, display star.fill button
        if favorites.first(where: {$0.name == launch.name}) != nil {
            cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cell.favorite = true
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            cell.favorite = false
        }
        
        cell.titleLabel.text = launch.name
        
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
        let launch = filteredLaunches[indexPath.row]
        
        vc.launch = launch
        
        show(vc, sender: nil)
    }
}

