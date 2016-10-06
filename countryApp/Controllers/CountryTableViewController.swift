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
    let countryStore = CountryStore()

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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        countryStore.allCountries(completionHandler: { (result,error) in
            self.countries.removeAllObjects()
            self.countries.addObjects(from: result)
            self.tableView.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath)
        let country = countries[(indexPath as NSIndexPath).row] as? Country
        cell.textLabel?.text=country?.name
        // Configure the cell...

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier=="showCountryDetails"){
            if let detailController = segue.destination as? CountryDetailViewController{
                detailController.country=sender as? Country
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showCountryDetails", sender: countries[(indexPath as NSIndexPath).row])
    }
    
    //MUST REMOVE
    fileprivate func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
}
