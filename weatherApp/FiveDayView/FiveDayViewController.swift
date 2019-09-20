//
//  FiveDayViewController.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 09/09/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import UIKit

class FiveDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , FiveDayViewModelProtocol{
   
   
   
    @IBOutlet weak var tableView: UITableView!
    var location = ""
    var name = ""
    var tables = [["Day"],["Min Temp"],["Max Temp"]]
    lazy var viewModel = FiveDayViewModel()
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FiveDayTableCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.activityIndicator()
        viewModel.delegate = self
        viewModel.fetchData(location : location)
    }
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
        tableView.addSubview(indicator)
        UIView.animate(withDuration: 2) {
            self.indicator.transform = CGAffineTransform(scaleX: 10, y: 10)
        }
        indicator.startAnimating()
        indicator.isHidden = false
        indicator.hidesWhenStopped = true
    }
    func removeIndicator(){
     indicator.stopAnimating()
     indicator.isHidden = true
    }
    func fetchDay(day: [String]) {
        tables[0] = day
    }
    
    func showTable() {
        self.tableView.reloadData()
    }
    
    func fetchMaxTemp(temp: [String]) {
        tables[1] = temp
    }
    
    func fetchMinTemp(temp: [String]) {
       tables[2] = temp
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Location", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables[0].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FiveDayTableCellTableViewCell
        cell.configureCell(table : tables,indexPath : indexPath)
        return cell
    }
}
