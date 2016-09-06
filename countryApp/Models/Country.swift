//
//  Country.swift
//  countryApp
//
//  Created by Axel Collard Bovy on 31/8/16.
//  Copyright © 2016 Axel Collard Bovy. All rights reserved.
//

import UIKit

class Country: NSObject {
    let name : String
    let code : String
    
    init(json : AnyObject){
        if let countriesPropertiesDictionary = json as? [String:AnyObject]{
            self.name=countriesPropertiesDictionary["name"] as! String
            self.code=countriesPropertiesDictionary["alpha2Code"] as! String
        }else{
            self.name="Wrong JSON"
            self.code="WJSON"
        }
    }
    
    init(name : String, code: String) {
        self.name = name
        self.code = code
    }
    
}
