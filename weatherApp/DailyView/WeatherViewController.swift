//
//  WeatherViewController.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 14/08/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,WeatherViewModelProtocol {
    
    var weatherDescription = ""
    var city = ""
    var main = ""
    var icon = ""
    var mintemp = ""
    var maxtemp = ""
    var pressure = ""
    var sunrise = ""
    var sunset = ""
    var name = ""
    var location = ""
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func fetchResponseDescription(description: String) {
       
       weatherLabel.text = description
    }
    
    func fetchResponseMain(main: String) {
        self.mainLabel.text = main
    }
   
    func fetchmaxTemp(temp: String) {
        self.maxTempLabel.text = temp
    }
    func fetchminTemp(temp: String) {
        self.minTempLabel.text = temp
    }
    func fetchPressure(pressure : String) {
        self.pressureLabel.text = pressure
    }
    func fetchSunset(sunset: String) {
       self.sunsetLabel.text = sunset
    }
    func fetchSunrise(sunrise: String) {
        self.sunriseLabel.text = sunrise
    }
    func removeIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    func fetchIcon(icon: String) {
        var imageURL = NSURL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL as! URL)
            DispatchQueue.main.async {
                if data != nil {
                    self.iconImage.image = UIImage(data:data!)
                }
            }
        }
    }
    func alert(message: String) {
        let alert = UIAlertController(title: "Invalid Location", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    lazy var viewModel = ViewModel() //difference between this being inside viewdidload and outside it
    override func viewDidLoad() {
       
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        viewModel.delegate = self
        viewModel.fetchData(location : location)
       
    }
}
