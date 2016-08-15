//
//  StationDetailScreen.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import UIKit

class StationDetailScreen: UITableViewController {
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var stationLabel: UILabel!
    
    var station : Station!
    
    private var delegate : StationSelectDelegate?
    private var direction : CitiesDirectionType?
    
    
    func setStationSelectDelegate(delegate: StationSelectDelegate, forDirection: CitiesDirectionType) {
        self.delegate = delegate
        self.direction = forDirection
    }
    
    
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        setStationInfo()
        
        self.navigationItem.title = station.stationTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выбрать", style: UIBarButtonItemStyle.Done, target: self, action: #selector(StationDetailScreen.chooseButtonClicked))
    }
    
    private func setStationInfo() {
        countryLabel.text = station.countryTitle
        regionLabel.text = station.regionTitle
        cityLabel.text = station.cityTitle
        districtLabel.text = station.districtTitle
        stationLabel.text = station.stationTitle
    }
    
    func chooseButtonClicked() {
        if delegate != nil && direction != nil {
            delegate!.didSelectStation(station, direction: direction!)
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
