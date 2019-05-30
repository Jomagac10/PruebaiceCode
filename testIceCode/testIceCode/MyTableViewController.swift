//
//  TableViewController.swift
//  testIceCode
//
//  Created by Jose Manuel García Chávez on 5/30/19.
//  Copyright © 2019 Unam. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class MyTableViewController: UITableViewController,UISearchBarDelegate {
    
    let reuseIdentifier = "Cell"
    var amis:[amiibo] = []
    let searchController = UISearchController(searchResultsController: nil)
    let Ami: DetailsController = DetailsController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.gray
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        searchController.searchBar.delegate = self

        consumeAPI(with: "https://www.amiiboapi.com/api/amiibo/")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return amis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        cell.textLabel?.text = "\(amis[indexPath.row].name) - \(amis[indexPath.row].amiiboSeries)"
        let url = URL(string: amis[indexPath.row].image)
        cell.imageView?.kf.setImage(with: url)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Ami.ami = amis[indexPath.row]
        self.navigationController?.pushViewController(self.Ami, animated: true)
    }
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        consumeAPI(with: "https://www.amiiboapi.com/api/amiibo/?name=\(searchText)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        consumeAPI(with: "https://www.amiiboapi.com/api/amiibo/")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func consumeAPI(with url: String){
        Alamofire.request(url).responseData { (dataResponse) in
            if let err = dataResponse.error{
                print("Hubo un error", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            //            let testString = String(data: data, encoding: .utf8 )
            //            print(testString ?? "")
            
            do{
                
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                self.amis.removeAll()
                
                searchResult.amiibo.forEach({ (ami) in
                    self.amis.append(amiibo(name: ami.name, image: ami.image, amiiboSeries: ami.amiiboSeries, release: ami.release))
                    self.tableView.reloadData()
                })
                
            }catch let decodeError{
                //                print("Error: ", decodeError)
            }
        }
    }
    
    struct SearchResults: Decodable{
        let amiibo: [amiibo]
    }

    

    

   
}
