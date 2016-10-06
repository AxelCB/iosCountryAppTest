//
//  Constants.swift
//  countryApp
//
//  Created by Axel Collard Bovy on 28/9/16.
//  Copyright © 2016 Axel Collard Bovy. All rights reserved.
//

import Foundation

struct Constants{
    //MARK: Rest Countries API
    struct RestCountriesAPI{
        static let baseURL="https://restcountries.eu/rest"
        
        struct Methods {
            static let allCountries="/v1/all"
        }
    }
}
