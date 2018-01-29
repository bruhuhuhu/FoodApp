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
        mainView.mainViewDelegate = self
        
        // Background
        self.view.backgroundColor = UIColor.lightGray
        
        
        // Autolayout
        self.view.addSubview(mainView)
        constrain (mainView) { mainView in
        mainView.left == mainView.superview!.left
        mainView.right == mainView.superview!.right
        }
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                mainView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0), mainView.bottomAnchor.constraintEqualToSystemSpacingBelow(guide.bottomAnchor, multiplier: 1.0)
                ])
            
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                mainView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: standardSpacing)
                ])
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
    
    
    func didSelectPartnerList() {
    }
    
    func didSelectDeliveryAddress(deliverAddress: String?) {
       
    }
    
}

