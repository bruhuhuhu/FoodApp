//
//  DeliveryAddressViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 17/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

var deliveryAddressView: DeliveryAddressView!


class DeliveryAddressViewController: UIViewController, UITextFieldDelegate,DeliveryAddressViewDelegate {
    
    
    var deliveryAddressEntered: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deliveryAddressView = DeliveryAddressView(frame: CGRect.zero)
        deliveryAddressView.deliveryAddressTextField.text = deliveryAddressEntered
        deliveryAddressView.deliveryAddressTextField.delegate = self
        
        deliveryAddressView.deliveryAddressViewDelegate = self
        
        // Background
        self.view.backgroundColor = UIColor.lightGray
        
        
        // Autolayout ---- to be edited for iphone x
        self.view.addSubview(deliveryAddressView)
        // Autolayout ---- to be edited for iphone x
        constrain (deliveryAddressView) { deliveryAddressView in
            deliveryAddressView.left == deliveryAddressView.superview!.left
            deliveryAddressView.right == deliveryAddressView.superview!.right
        }
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                deliveryAddressView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0), deliveryAddressView.bottomAnchor.constraintEqualToSystemSpacingBelow(guide.bottomAnchor, multiplier: 1.0)
                ])
            
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                deliveryAddressView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo: deliveryAddressView.bottomAnchor, constant: standardSpacing)
                ])
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let deliveryAddress = textField.text!
        mainView.deliveryAddressArray.append(deliveryAddress)
        
        //refreshing the view
        
        deliveryAddressView.deliveryAddressTableView.reloadData()
        mainView.deliveryAddressTableView.reloadData()
        viewDidLayoutSubviews()
        
        //change view to second screen after return is clicked
        let foodSelectionVC = FoodSelectionViewController()
        foodSelectionVC.deliveryAddressEntered = deliveryAddress
        self.present (foodSelectionVC, animated: true, completion: nil)
        
        
        textField.text = "\(textField.text!)"
        return false
    }
    
    override func viewDidLayoutSubviews() {
        //refreshes table view after data entry
        deliveryAddressView.updateConstraints()
        deliveryAddressView.deliveryAddressTableView.beginUpdates()
        deliveryAddressView.deliveryAddressTableView.setNeedsDisplay()
        deliveryAddressView.deliveryAddressTableView.endUpdates()
        
        mainView.updateConstraints()
        mainView.deliveryAddressTableView.beginUpdates()
        mainView.deliveryAddressTableView.setNeedsDisplay()
        mainView.deliveryAddressTableView.endUpdates()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func foodSelectionSwitch(deliveryAddress: String) {
        let foodSelectionVC = FoodSelectionViewController()
        foodSelectionVC.deliveryAddressEntered = deliveryAddress
        self.present (foodSelectionVC, animated: true, completion: nil)
    }
    

}
