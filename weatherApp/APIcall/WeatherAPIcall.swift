//
//  File.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 03/09/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import Foundation
import Alamofire
enum type {
    case daily
    case five_days
}


class WeatherAPIcall{
    
    static var location : String = ""
    
    //"https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
    
    static let baseURL_Daily = "https://api.openweathermap.org/data/2.5/weather?q="
    static let baseURL_5Days = "https://api.openweathermap.org/data/2.5/forecast?q="
    static let appid = "e88f2dd44543104f21f18f3b13750334"
    class func apiCall(location : String, type : type,completionHandler: @escaping(Data?,String?) -> ()) {
        
        var url = ""
        print("--\(location)")
        switch type{
        case .daily:
            url =   "\(baseURL_Daily)\(location)&appid=\(appid)"
            print(url)
        
        case .five_days:
            url =   "\(baseURL_5Days)\(location)&appid=\(appid)"
        }
       
       let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
        dispatchQueue.async{
            print(Thread.isMainThread)
            print("$$$\(url)")
        
            
            Alamofire.request(url).responseJSON {response in
                
                print(response)
                if let jsonDictionary = response.result.value as? [String : Any]{
                    if jsonDictionary.count <= 2 {
                        let error = "invalid location"
                        completionHandler(nil,error)
                    }
                    else{
                        completionHandler(response.data,nil)
                        print("____________")
                        print(response.data)
                    }
                }
            }
        }
    }
}

extension UIImageView {
    
    func setIcon(_ imgURLString: String?) {
       DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: imgURLString!)!)
            DispatchQueue.main.async {
                self.image =  UIImage(data: data!) 
            }
        }
    }
}

