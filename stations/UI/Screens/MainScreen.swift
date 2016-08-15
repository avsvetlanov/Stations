//
//  MainScreen.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import UIKit

class MainScreen: UITableViewController, StationSelectDelegate {
    
    @IBOutlet weak var stationFromTitleLabel: UILabel!
    @IBOutlet weak var stationFromSubtitleLabel: UILabel!
    
    @IBOutlet weak var stationToTitleLabel: UILabel!
    @IBOutlet weak var stationToSubtitleLabel: UILabel!
    
    @IBOutlet weak var datePickerTextField: UITextField!
    
    @IBOutlet weak var stationFromCell: UITableViewCell!
    @IBOutlet weak var stationToCell: UITableViewCell!
    @IBOutlet weak var dateCell: UITableViewCell!
    
    var citiesContainer : CitiesContainer?
    
    var picker : UIDatePicker!
    
    override func viewDidLoad() {
        
        configureDatePicker()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: #selector(MainScreen.onUpdateButtonPressed(_:)))
    }
    
    func onUpdateButtonPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Обновление списка станций", message: "Пожалуйста, подождите", preferredStyle: .Alert)
        self.presentViewController(alert, animated: true) {
            StationsController.sharedInstance.loadStationsFromServer(StationsRequestDelegate(onStart: {
                }, onFinish: { (dictResponse) in
                    dispatch_sync(dispatch_get_main_queue(), {
                        alert.title = "Выполнено"
                        alert.message = "Обновление прошло успешно"
                        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.Default, handler: nil))
                    })
                }, onError: { (message) in
                    dispatch_sync(dispatch_get_main_queue(), {
                        alert.title = "Ошибка"
                        alert.message = message
                        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.Default, handler: nil))
                    })
            }))
        }
        
    }
    
    func configureDatePicker() {
        self.picker = UIDatePicker()
        
        if let picker = self.picker {
            picker.sizeToFit()
            picker.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
            picker.datePickerMode = .Date
            picker.minimumDate = NSDate()
            picker.addTarget(self, action: #selector(MainScreen.datePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
            datePickerTextField.inputView = picker
            
            // add a done button
            let toolbar = UIToolbar()
            toolbar.barStyle = UIBarStyle.Default
            toolbar.translucent = true
            toolbar.tintColor = nil
            toolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Выбрать", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MainScreen.dismissPicker))
            toolbar.setItems([doneButton], animated: false)
            datePickerTextField.inputAccessoryView = toolbar
        }
    }
    
    func showPicker() {
        datePickerTextField.becomeFirstResponder()
    }
    
    func dismissPicker() {
        datePickerTextField.resignFirstResponder()
    }
    
    func datePickerValueChanged(sender : UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        datePickerTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            switch cell {
            case stationFromCell:
                let cities = StationsController.sharedInstance.getCities(CitiesDirectionType.FROM)
                let vc = StationsListScreen(cities: cities)
                vc.setStationSelectDelegate(self, forDirection: CitiesDirectionType.FROM)
                self.navigationController?.pushViewController(vc, animated: true)
            case stationToCell:
                let cities = StationsController.sharedInstance.getCities(CitiesDirectionType.TO)
                let vc = StationsListScreen(cities: cities)
                vc.setStationSelectDelegate(self, forDirection: CitiesDirectionType.TO)
                self.navigationController?.pushViewController(vc, animated: true)
            case dateCell:
                showPicker()
            default:
                break
            }
        }
    }
    
    /* StationSelectDelegate */
    func didSelectStation(station: Station, direction: CitiesDirectionType) {
        switch direction {
        case .FROM:
            stationFromTitleLabel.text = station.stationTitle
            stationFromSubtitleLabel.text = station.countryTitle + ", " + station.cityTitle
        case .TO:
            stationToTitleLabel.text = station.stationTitle
            stationToSubtitleLabel.text = station.countryTitle + ", " + station.cityTitle
        }
    }
}
