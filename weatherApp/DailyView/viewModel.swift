//
//  viewModel.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 11/09/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import Foundation

protocol WeatherViewModelProtocol : class {
    func fetchResponseDescription(description : String)
    func fetchResponseMain(main : String)
    func fetchIcon(icon :String)
    func fetchSunrise(sunrise : String)
    func fetchSunset(sunset : String)
    func fetchminTemp(temp : String)
    func fetchmaxTemp(temp : String)
    func fetchPressure(pressure : String)
    func alert(message : String)
    func removeIndicator()
}


class ViewModel{
    weak var delegate : WeatherViewModelProtocol?
    lazy var weatherAPI = WeatherAPIcall()
    
    func fetchData(location : String) -> () {
        WeatherAPIcall.apiCall(location: location,type : .daily,completionHandler: { [weak self]
            (response,error) in
            
            if response != nil{
                print(response!)
                
                let weather = try? JSONDecoder().decode(Weather.self, from: response!)
                print("####\(String(describing: weather))")
                
                if weather!.cod == 200{
                    print("###@@@\(weather!.weather[0].weatherDescription)")
                    self?.delegate?.removeIndicator()
                    var desc = weather!.weather[0].weatherDescription
                    self?.delegate?.fetchResponseDescription(description: desc)
                    self?.delegate?.fetchResponseMain(main: weather!.weather[0].main)
                    self?.delegate?.fetchIcon(icon: weather!.weather[0].icon)
                    print(weather!.weather[0].icon)
                    self?.delegate?.fetchminTemp(temp: "Minimum Temperature : \(String(format:"%.2f", weather!.main.tempMin-273))°C")
                    self?.delegate?.fetchmaxTemp(temp: "Maximum Temperature : \(String(format:"%.2f", weather!.main.tempMax-273))°C")
                    self?.delegate?.fetchPressure(pressure: "Pressure : \(weather!.main.pressure)")
                    self?.delegate?.fetchSunset(sunset: "Sunset : \(self?.dateTime(datetime : weather!.sys.sunset as! Double,timeZone: TimeZone(secondsFromGMT : weather!.timezone) as! TimeZone ) as! String)")
                    self?.delegate?.fetchSunrise(sunrise: "Sunrise : \(self?.dateTime(datetime : weather!.sys.sunrise as! Double,timeZone: TimeZone(secondsFromGMT : weather!.timezone) as! TimeZone ) as! String)")
                }
                else{
                    self?.delegate!.alert(message: "Enter valid location")
                }
            }
            else{
                self?.delegate!.alert(message: "No response")
               }
        })
    }
    func dateTime( datetime : Double,timeZone : TimeZone)->String{
        var dateTimeformatted = ""
        print("**\(datetime)")
        let date = Date(timeIntervalSince1970: datetime )
        print("--\(date)")
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = timeZone as TimeZone
        let localDate = dateFormatter.string(from: date)
        dateTimeformatted = "\(localDate)"
        return dateTimeformatted
    }
}
