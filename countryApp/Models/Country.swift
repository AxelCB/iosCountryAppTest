//
//  Country.swift
//  countryApp
//
//  Created by Axel Collard Bovy on 31/8/16.
//  Copyright © 2016 Axel Collard Bovy. All rights reserved.
//

import UIKit
import ObjectMapper

class Country : Mappable, CustomStringConvertible, CustomDebugStringConvertible {
    var name : String?
    var code : String?
    
    init(json : AnyObject){
        if let countriesPropertiesDictionary = json as? [String:AnyObject]{
            self.name=countriesPropertiesDictionary["name"] as? String
            self.code=countriesPropertiesDictionary["alpha2Code"] as? String
        }else{
            self.name="Wrong JSON"
            self.code="WJSON"
        }
    }
    
    init(name : String, code: String) {
        self.name = name
        self.code = code
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        name <- map["name"]
        code <- map["alpha2Code"]
    }
    
    required init?(map: Map) {
        
    }
    
    public var description: String {
        return "\(code) - \(name)"
    }
    public var debugDescription: String {
        return "\(code) - \(name)"
    }
}
