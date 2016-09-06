//
//  CountryTableViewController.swift
//  countryApp
//
//  Created by Axel Collard Bovy on 30/8/16.
//  Copyright © 2016 Axel Collard Bovy. All rights reserved.
//

import UIKit

class CountryTableViewController: UITableViewController {
    
    var countries = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
	
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func viewWillAppear(animated: Bool) {
        let countriesUrl = NSURL(string:"https://restcountries.eu/rest/v1/all")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(countriesUrl){ (data,response,error) in
            if error == nil{
                if let data = data {
                    var parsedResult = AnyObject?()
                    let countriesArrayToAssign = NSMutableArray()
                    do{
                        parsedResult=try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    }catch{
                        print("Could not parse data")
                        return
                    }
                    print(parsedResult)
                    if let countriesArray = parsedResult as? [AnyObject]{
                        for countryJSON in countriesArray{
                            countriesArrayToAssign.addObject(Country(json: countryJSON))
                        }
                    }
                    self.performUIUpdatesOnMain({
                        self.countries=countriesArrayToAssign
                        self.tableView.reloadData()
                    })
                }
            }
        }
        task.resume();
        /*
        let country = Country(name: "Argentina",code: "AR")
        self.countries.addObject(country)
        let country2 = Country(name: "Brazil",code: "BR")
        self.countries.addObject(country2)
        */
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("country", forIndexPath: indexPath)
        let country = countries[indexPath.row] as? Country
        cell.textLabel?.text=country?.name
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier=="showCountryDetails"){
            if let detailController = segue.destinationViewController as? CountryDetailViewController{
                detailController.country=sender as? Country
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showCountryDetails", sender: countries[indexPath.row])
    }
    
    //MUST REMOVE
    private func performUIUpdatesOnMain(updates: () -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            updates()
        }
    }
}
