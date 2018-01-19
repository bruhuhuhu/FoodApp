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


class DeliveryAddressViewController: UIViewController, UITextFieldDelegate {
    
    
    var addressEntered: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        deliveryAddressView = DeliveryAddressView(frame: CGRect.zero)
        deliveryAddressView.addressTextField.text = addressEntered
        self.view.addSubview(deliveryAddressView)
        deliveryAddressView.addressTextField.delegate = self
        
        // Background
        self.view.backgroundColor = UIColor.lightGray
        
        // Autolayout ---- to be edited for iphone x
        constrain (deliveryAddressView) { deliveryAddressView in
        deliveryAddressView.edges == inset (deliveryAddressView.superview!.edges, 50,0,0,0)
            
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = "The address is \(textField.text!)"
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
