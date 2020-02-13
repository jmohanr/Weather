//
//  LocationSearchTableView.swift
//  Weather Data
//
//  Created by Jagan on 11/02/20.
//  Copyright © 2020 Jagan. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableView: UITableViewController{
   
    var mapView: MKMapView?
    var matchingItems: [MKMapItem] = []
    var recentSearch:[MKMapItem] = []
    let searchController = UISearchController(searchResultsController: nil)
    var fetchingSelectedData:((MKPlacemark,MKMapItem)->(Void))?
    var searchedData:((MKMapItem)->(Void))?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.searchController.searchBar.delegate = self;
        self.tableView.tableHeaderView = searchController.searchBar
        self.matchingItems = self.recentSearch
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell

        let selectedItem = matchingItems[indexPath.row].placemark
        cell?.nameLabel?.text = selectedItem.name
        cell?.dataLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        dismiss(animated: true, completion: nil)
        let selectedItem = matchingItems[indexPath.row].placemark
        self.fetchingSelectedData?(selectedItem, matchingItems[indexPath.row])
    }

}

extension LocationSearchTableView : UISearchResultsUpdating,UISearchBarDelegate {
    func parseAddress(selectedItem:MKPlacemark) -> String {
        
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       dismiss(animated: true, completion: nil)

    }
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
  
}
