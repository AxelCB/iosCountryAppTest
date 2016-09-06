//
//  CountryDetailViewController.swift
//  countryApp
//
//  Created by Axel Collard Bovy on 1/9/16.
//  Copyright © 2016 Axel Collard Bovy. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    var country : Country?
    @IBOutlet weak var countryTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        self.countryTitle.text=country?.name
    }
}
