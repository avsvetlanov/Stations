//
//  StationsScreen.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import UIKit

//todo check !
class StationsListScreen: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    private var cities : [City]!
    private var filteredCities = [City]()
    private var shouldShowSearchResults = false
    
    private var searchController : UISearchController!
    private let cellReuseId = "cell"
    
    private var delegate : StationSelectDelegate?
    private var direction : CitiesDirectionType?
    
    init(cities : [City]){
        self.cities = cities
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        
        if let directionDescription = direction?.description {
            self.navigationItem.title = directionDescription
        } else {
            self.navigationItem.title = "Список станций"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.frame.size.width = self.view.frame.size.width
        
        self.tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
    }
    
    func setStationSelectDelegate(delegate: StationSelectDelegate, forDirection: CitiesDirectionType) {
        self.delegate = delegate
        self.direction = forDirection
    }
    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if shouldShowSearchResults {
            return filteredCities.count
        } else {
            return cities.count
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredCities[section].stations.count
        } else {
            return cities[section].stations.count
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if shouldShowSearchResults {
            return filteredCities[section].countryTitle + ", " + filteredCities[section].cityTitle
        } else {
            return cities[section].countryTitle + ", " + cities[section].cityTitle
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseId, forIndexPath: indexPath) as UITableViewCell
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredCities[indexPath.section].stations[indexPath.row].stationTitle
        } else {
            cell.textLabel?.text = cities[indexPath.section].stations[indexPath.row].stationTitle
        }
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    /* click events */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("StationDetailScreen") as! StationDetailScreen
        
        if shouldShowSearchResults {
            vc.station = filteredCities[indexPath.section].stations[indexPath.row]
        } else {
            vc.station = cities[indexPath.section].stations[indexPath.row]
        }
        
        if delegate != nil && direction != nil {
            vc.setStationSelectDelegate(delegate!, forDirection: direction!)
        }
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
    /* UISearchBarDelegate */
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    
    /* UISearchResultsUpdating */
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        if searchString!.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = StationsController.sharedInstance.findStationsByText(cities, text: searchString!)
        }
        tableView.reloadData()
    }
}
