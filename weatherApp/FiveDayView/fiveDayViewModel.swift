//
//  fiveDayViewModel.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 12/09/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import Foundation
import UIKit
protocol FiveDayViewModelProtocol : class{
    func fetchMaxTemp(temp : [String])
    func fetchMinTemp(temp : [String])
    func fetchDay(day : [String])
    func showAlert(message : String)
    func showTable()
    func removeIndicator()
}
class FiveDayViewModel {
    
    
    weak var delegate : FiveDayViewModelProtocol?
    lazy var weatherAPIcall = WeatherAPIcall()
    var maxTemp: [String] = ["max"]
    var minTemp : [String] = ["min"]
    var days : [String] = ["Day"]
    var dayNames : [String] = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    // DO not pass view references
    func fetchData(location : String){
        WeatherAPIcall.apiCall(location : location,type : .five_days, completionHandler: { [weak self]
         (response,error) in
         
         if response != nil{
         print(response)
         
         let weather = try? JSONDecoder().decode(FiveWeather.self, from: response!)
         print("####\(weather)")
         
         if weather!.cod == "200" {
         for day in 1...5{
            
            var ConvertedToDay = ""
            var dayNumber = 0
            
            if day == 1{
                self?.maxTemp.append("\(String(format:"%.2f", weather!.list[0].main.tempMin-273))°C")
                self?.minTemp.append("\(String(format:"%.2f", weather!.list[0].main.tempMax-273))°C")
                self?.days.append("Today")
            }
            else if day == 2{
                self?.days.append("Tomorrow")
                self?.maxTemp.append("\(String(format:"%.2f", weather!.list[(day-1)*7].main.tempMin-273))°C")
                self?.minTemp.append("\(String(format:"%.2f", weather!.list[(day-1)*7].main.tempMax-273))°C")
            }
            else{
                self?.maxTemp.append("\(String(format:"%.2f", weather!.list[(day-1)*7].main.tempMin-273))°C")
                self?.minTemp.append("\(String(format:"%.2f", weather!.list[(day-1)*7].main.tempMax-273))°C")
                ConvertedToDay = (self?.dateTime(datetime: weather!.list[(day-1)*7].dt))!
                dayNumber = (self?.getDayOfWeek(today: ConvertedToDay))!-1
                self?.days.append("\(self?.dayNames[dayNumber] as! String)")
            }
            }
            self?.delegate?.fetchMinTemp(temp: self!.maxTemp )
            self?.delegate?.fetchMaxTemp(temp: self!.minTemp)
            self?.delegate?.fetchDay(day: self!.days)
            self?.delegate?.removeIndicator()
            self?.delegate?.showTable()
         }
         }
         else{
         self?.delegate?.showAlert(message: "Invalid Location")
         }
    })
 }
    func getDayOfWeek(today:String)->Int {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy:MM:dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)// DO not use NSCalendar. Use Calendar instead
        let myComponents = myCalendar.dateComponents([.weekday], from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    func dateTime( datetime : Int)->String{
        var dateTimeformatted = ""
        print("**\(datetime)")
        let date = Date(timeIntervalSince1970: TimeInterval(datetime) )
        print("--\(date)")
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.dateFormat = "yyyy:MM:dd"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        dateTimeformatted = "\(localDate)"
        return dateTimeformatted
    }

}

