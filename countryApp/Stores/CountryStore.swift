//
//  CountryStore.swift
//  countryApp
//
//  Created by Axel Collard Bovy on 28/9/16.
//  Copyright © 2016 Axel Collard Bovy. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper
import AlamofireImage

class CountryStore: NSObject {
    
    func allCountries(completionHandler: @escaping (_ result: [Country], _ error: NSError?) -> Void){
        Alamofire.request(Constants.RestCountriesAPI.baseURL+Constants.RestCountriesAPI.Methods.allCountries).responseArray { (response: DataResponse<[Country]>) in
            let arrayResponse = response.result.value
            guard let allcountriesResponse = arrayResponse else {
                print("No countries")
                return
            }
            DispatchQueue.main.async {
                completionHandler(allcountriesResponse,response.result.error as NSError?)
            }

        }
    }
  
    func countryFlag(url: String,completionHandler: @escaping (_ result: Data) -> Void){
        do{
            let imageURL = URL(string: url)
            let imageData = try Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                completionHandler(imageData)
            }
        }catch{
            print("Error")
        }
        /*
        Alamofire.request(url).responseImage(completionHandler: { response in
            guard let image = response.result.value else{
                print("No data returned")
                return
            }
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            print("image downloaded: \(image)")
            DispatchQueue.main.async {
                completionHandler(image)
            }
        })*/
    }
}
