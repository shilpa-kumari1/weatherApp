//
//  ViewController.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 14/08/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, ShowErrorProtocol {
   
    var location = ""
    @IBOutlet weak var locationTextField: UITextField!
    @IBAction func clearButton(_ sender: Any) {
        locationTextField.text = ""
    }
    @IBAction func search(_ sender: Any) {
        var homeViewModel = HomeViewModel()
        homeViewModel.delegate = self
        homeViewModel.checkEmptyLocation(location: locationTextField.text!)
        
        if let next = self.storyboard?.instantiateViewController(withIdentifier: "SegmentedControlViewController") as? SegmentedControlViewController{
            
            self.navigationController?.pushViewController(next, animated: true)
            next.location = locationTextField.text!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
    }
    func showErrorMessage() {
        let alert = UIAlertController(title: "Empty Location", message: "Enter a location", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

