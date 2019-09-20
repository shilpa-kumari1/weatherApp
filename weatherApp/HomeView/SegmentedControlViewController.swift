//
//  SegmentedControlViewController.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 11/09/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import UIKit


class SegmentedControlViewController: UIViewController {
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
  
    var location = ""
    
   private lazy var WeatherViewController: WeatherViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        viewController.location = self.location
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var FiveDayViewController: FiveDayViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "FiveDayViewController") as! FiveDayViewController
        viewController.location = self.location
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = location.uppercased()
        setupView()
      }
  
  func setupView(){
        setupSegmentedControl()
        initialViewSetUp()
    }
    func initialViewSetUp(){
        if segmentedControl.selectedSegmentIndex == 0{
            add(asChildViewController: WeatherViewController)
        }
    }
    func setupSegmentedControl(){
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Daily", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "5 Days", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    func updateView(){
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: FiveDayViewController)
            add(asChildViewController: WeatherViewController)
            
        } else {
            remove(asChildViewController: WeatherViewController)
            add(asChildViewController: FiveDayViewController)
        }
        
    }
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
}
