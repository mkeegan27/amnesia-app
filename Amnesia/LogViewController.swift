//
//  LogViewController.swift
//  Amnesia
//
//  Created by Mike Keegan on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import MapKit
import AddressBookUI

class LogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblV: UITableView!
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LogMgr.addLoc(GPSNew: 0, locationNameNew: 0, timeBeginNew: 0, timeEndNew: 0)
        
        self.tblV.tableFooterView = UIView()
        self.tblV.separatorStyle = UITableViewCellSeparatorStyle.none

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(LogViewController.refresh), for: UIControlEvents.valueChanged)
        tblV.addSubview(refreshControl)
        
        // Do any additional setup after loading the view.
        
        
//        var longitude :CLLocationDegrees = -72.525909
//        var latitude :CLLocationDegrees = 42.391075
//        
//        var location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
//        //print(location)
//        
//        
//        CLGeocoder().reverseGeocodeLocation(location)
//        {
//            (placemarks, error) -> Void in
//            
//            let placeArray = placemarks as [CLPlacemark]!
//            
//            // Place details
//            var placeMark: CLPlacemark!
//            placeMark = placeArray?[0]
//            
//            print(ABCreateStringWithAddressDictionary(placeMark.addressDictionary!, false))
//            
            // Address dictionary
            //print(placeMark.addressDictionary)
            
//            // Location name
//            if let locationName = placeMark.addressDictionary?["Name"] as? NSString
//            {
//                print(locationName)
//            }
//            // subLocality KEY DOES NOT WORK
//            if let locality = placeMark.addressDictionary?["SubLocality"] as? NSString
//            {
//                print(locality)
//            }
//
//            // Street address
//            if let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString
//            {
//                print(street)
//            }
//            
//            // City
//            if let city = placeMark.addressDictionary?["City"] as? NSString
//            {
//                print(city)
//            }
//            
//            // Zip code
//            if let zip = placeMark.addressDictionary?["ZIP"] as? NSString
//            {
//                print(zip)
//            }
//            
//            // Country
//            if let country = placeMark.addressDictionary?["Country"] as? NSString
//            {
//                print(country)
//            }
//        }
    }
    
    func refresh() {
        // Code to refresh table view
        tblV.reloadData()
        self.refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return newLocations.dataPoints.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tblV.dequeueReusableCell(withIdentifier: "LogCell") as! LogTableViewCell
        let timeSpent = newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1].timeSpent
        
        cell.changeLabelText(newText: newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1].locName)
        cell.changeTimeText(newText: getTimeLabel(secs: timeSpent))
        cell.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 122/255, blue: 254/255, alpha: Float(timeSpent)/Float(newLocations.longestTime)*0.8)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let block = UITableViewRowAction(style: .normal, title: "Block") { action, index in
//            print("Block")
//            LogMgr.logset.remove(at: indexPath.row)
//        }
        let delete = UITableViewRowAction(style: .default, title: "Delete") { action, index in
            //print("Delete")
            newLocations.dataPoints.remove(at: indexPath.row)
            self.tblV.reloadData()
            
            //delete function does not work all the time
            //also does not delete map annotations
        }
        return [delete]
//        LogMgr.logset.remove(at: indexPath.row)
//        tblV.reloadData()
    }
    

    func getTimeLabel(secs: Int) -> String {
        if secs < 60 {
            return "\(secs) seconds"
        } else if secs < 3600 {
            if secs/60 == 1 {
                return "\(secs/60) minute"
            }
            return "\(secs/60) minutes"
        } else if secs < 3600*24 {
            if secs/3600 == 1 {
                return "\(secs/3600) hour"
            }
            return "\(secs/3600) hours"
        } else {
            if secs/3600/24 == 1 {
                return "\(secs/3600/24) day"
            }
            return "\(secs/3600/24) days"
        }
    }

    
    
}
