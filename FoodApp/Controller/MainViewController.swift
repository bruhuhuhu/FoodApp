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


class MainViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = MainView(frame: CGRect.zero)
        self.view.addSubview(mainView)
        mainView.addressTextField.delegate = self
        
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
    
    
    // Keyboard 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //dismiss keyboard
        textField.resignFirstResponder()
        let deliveryAddress = textField.text!
        
        //adding new entry into the addressArray
        mainView.addressArray.append(deliveryAddress)
        textField.text = "The address is \(deliveryAddress)"
        
        //refreshing the view
        mainView.addressTableView.reloadData()
        viewDidLayoutSubviews()
        
        //change view to second screen after return is clicked
        let deliveryAddressVC = DeliveryAddressViewController()
        deliveryAddressVC.addressEntered = deliveryAddress
        self.present (deliveryAddressVC, animated: true, completion: nil)
      
        return false
    }
    
    
    override func viewDidLayoutSubviews() {
          //refreshes table view after data entry
          mainView.updateConstraints()
          mainView.addressTableView.beginUpdates()
          mainView.addressTableView.setNeedsDisplay()
          mainView.addressTableView.endUpdates()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    


}
