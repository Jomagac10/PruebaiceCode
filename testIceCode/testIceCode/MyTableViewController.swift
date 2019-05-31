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
    
    //MARK: Properties
    let reuseIdentifier = "Cell"
    var amis:[amiibo] = []
    let searchController = UISearchController(searchResultsController: nil)
    let Ami: DetailsController = DetailsController()

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return amis.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AmiiboCell
        cell._Name.text = "\(amis[indexPath.row].name)"
        cell._Series.text = "\(amis[indexPath.row].amiiboSeries)"
        let url = URL(string: amis[indexPath.row].image)
        cell._Image.kf.setImage(with: url)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Ami.ami = amis[indexPath.row]
        self.navigationController?.pushViewController(self.Ami, animated: true)
    }
 
    //MARK: SearchBar functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        consumeAPI(with: "https://www.amiiboapi.com/api/amiibo/?name=\(searchText)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        consumeAPI(with: "https://www.amiiboapi.com/api/amiibo/")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.gray
        
        tableView.register(UINib(nibName: "AmiiboTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        consumeAPI(with: "https://www.amiiboapi.com/api/amiibo/")
    }
    
    
    
    //MARK: API services
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
