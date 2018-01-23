//
//  MainViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 16/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

var mainView: MainView!


class MainViewController: UIViewController, MainViewDelegate {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = MainView(frame: CGRect.zero)
        self.view.addSubview(mainView)
        mainView.mainViewDelegate = self
        
        // Background
        self.view.backgroundColor = UIColor.lightGray

        
        // Autolayout ---- to be edited for iphone x
        constrain (mainView) { mainView in
        mainView.edges == inset (mainView.superview!.edges, 50,0,0,0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Switches
    
    
    // MARK: Switch to Partner List View
    func partnerListButtonSwitch() {
        let partnerListVC = PartnerListViewController()
        self.present (partnerListVC, animated: true, completion: nil)
    }
    // Switch to Delivery Address View When Tap on Enter Delivery Address
    func deliveryAddressButtonSwitch() {
        let deliveryAddressVC = DeliveryAddressViewController()
        self.present (deliveryAddressVC, animated: true, completion: nil)
       
    }
    
    // Switch to Food Selection View When Tap on Addresses on Main View Table View
    func deliveryAddressSwitch(deliveryAddress: String) {
        //let deliveryAddressVC = DeliveryAddressViewController()
        //self.present (deliveryAddressVC, animated: true, completion: nil)
        
        let foodSelectionVC = FoodSelectionViewController()
        foodSelectionVC.deliveryAddressEntered = deliveryAddress
        self.present (foodSelectionVC, animated: true, completion: nil)
    }
    
}


//----------------------------------------------------//
// MARK: Keyboard and Switch to Delivery Address View

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        //dismiss keyboard
//        textField.resignFirstResponder()
//        let deliveryAddress = textField.text!
//
//        //adding new entry into the addressArray
//        mainView.deliveryAddressArray.append(deliveryAddress)
//        textField.text = "Enter Delivery Address"
//
//        //refreshing the view
//        mainView.deliveryAddressTableView.reloadData()
//        viewDidLayoutSubviews()
//
//        //change view to second screen after return is clicked
//        let deliveryAddressVC = DeliveryAddressViewController()
//        deliveryAddressVC.deliveryAddressEntered = deliveryAddress
//        self.present (deliveryAddressVC, animated: true, completion: nil)
//
//        return false
//    }
//
//
//    override func viewDidLayoutSubviews() {
//          //refreshes table view after data entry
//          mainView.updateConstraints()
//          mainView.deliveryAddressTableView.beginUpdates()
//          mainView.deliveryAddressTableView.setNeedsDisplay()
//          mainView.deliveryAddressTableView.endUpdates()
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.text = ""
//    }

//----------------------------------------------------//
