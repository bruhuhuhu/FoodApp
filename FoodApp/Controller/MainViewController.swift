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
    
    
    // Testing - Button
    let button: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("go delivery screen", for: .normal)
        view.backgroundColor = UIColor.blue
        return view
    }()
    // Testing - Button
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = MainView(frame: CGRect.zero)
        self.view.addSubview(mainView)
        mainView.addressTextField.delegate = self
        
        // Background
        self.view.backgroundColor = UIColor.lightGray

        
        // Autolayout ---- to be edited for iphone x
        constrain (mainView) { mainView in
        mainView.edges == inset (mainView.superview!.edges, 0,0,0,0)
            
        // Testing - Button
        view.addSubview(button)
        button.addTarget(self, action: #selector(pressButton), for: .touchDown)
            buttonConstraints()
            updateViewConstraints()
        // Testing - Button
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
    
    
    
    // Testing - Button
    func buttonConstraints(){
        constrain(button, view) {button, view in
            button.bottom == view.bottom - 40
            button.centerX == view.centerX
        }
        
    }

    
   @objc func pressButton(_sender: UIButton!){
    print ("To Delivery")
    let deliveryAddressVC = DeliveryAddressViewController()
//  self.navigationController?.pushViewController(deliveryAddressVC, animated: true)
//  print ("done 1")
    self.present (deliveryAddressVC, animated: true, completion: nil)
    }
    // Testing - Button


}
