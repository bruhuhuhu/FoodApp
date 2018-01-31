//
//  DeliveryAddressViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 17/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

class DeliveryAddressViewController: UIViewController {
    

    lazy var viewModel = DeliveryAddressViewModel()
    
    
    // Mark: - View model
    
    var deliveryAddressEntered: String = ""
    
    let mainVC = MainViewController()

    // MARK: - Define the UI elements

    var naviBar : UINavigationBar! = {
        
        //let nav = UINavigationController (rootViewController: deliveryVC)
        let naviBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Deliver Food To");
        let backBtn = UIBarButtonItem (barButtonSystemItem: .stop, target: self, action: #selector (didSelectBackButton))
        navItem.leftBarButtonItem = backBtn
        naviBar.setItems([navItem], animated: false);
        return naviBar
    }()
    
    let deliveryAddressTextField: UITextField! = {
        let textField = UITextField()
        textField.placeholder = "Enter Delivery Address"
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.text = ""
        textField.font = .systemFont(ofSize: 15)
        
        return textField
    }()
    
    let cellHeight = 50
    var deliveryAddressTableView = UITableView()

    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        viewModel.getDeliveryAddress()
       
        setupView()
        updateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setupView() {

        
        deliveryAddressTableView.delegate = self
        deliveryAddressTableView.dataSource = self
        deliveryAddressTableView.register(UITableViewCell.self, forCellReuseIdentifier: "deliveryAddressCell")
        
        self.deliveryAddressTextField.text = deliveryAddressEntered
        self.deliveryAddressTextField.delegate = self
        self.deliveryAddressTableView.rowHeight = 50
        
        self.view.addSubview(deliveryAddressTableView)
        self.view.addSubview(naviBar)
        self.view.addSubview(deliveryAddressTextField)
        
    }
    
    func updateConstraints(){
        naviBarConstraint()
        deliveryAddressTextFieldConstraint()
        deliveryAddressTableViewConstraint()
    }
    
    // MARK: - Constraints
    
    func naviBarConstraint (){
        constrain (naviBar, self.view) { navi, view in
            navi.width == view.width
            navi.height == 65
            navi.top == topLayoutGuideCartography
            navi.centerX == view.centerX
        }
    }
    
    func deliveryAddressTextFieldConstraint() {
        constrain(deliveryAddressTextField,naviBar){ deliveryAddressTF, naviBar in
            deliveryAddressTF.width == naviBar.width
            deliveryAddressTF.height == 40
            deliveryAddressTF.centerX == naviBar.superview!.centerX
            deliveryAddressTF.top == naviBar.bottom - 25
        }
    }

    
    func deliveryAddressTableViewConstraint(){
        deliveryAddressTableView.backgroundColor = UIColor.blue
        constrain(deliveryAddressTableView, deliveryAddressTextField) { deliveryAddressTV, deliveryAddressTF in
            deliveryAddressTV.width == deliveryAddressTF.width
            deliveryAddressTV.centerX == deliveryAddressTF.superview!.centerX
            deliveryAddressTV.height == 350
            deliveryAddressTV.top == deliveryAddressTF.bottom
        }
    }

    
    
    // MARK: - Did Select
    
    @objc func didSelectBackButton (){
        let currentController = self.getCurrentViewController()
        currentController?.dismiss(animated: true, completion: nil)
    }
    
    
    func didSelectFoodSelection(deliveryAddress: String) {
        let foodSelectionVC = FoodSelectionViewController()
        foodSelectionVC.deliveryAddressEntered = deliveryAddress
        self.present (foodSelectionVC, animated: true, completion: nil)
    }
    
    func getCurrentViewController() -> UIViewController? {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
    
}


extension DeliveryAddressViewController:  UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let newAddress = textField.text!
        viewModel.setDeliveryAddress(deliveryAddress: newAddress)

        
        self.deliveryAddressTableView.reloadData()
 
        
        //change view to second screen after return is clicked
        let foodSelectionVC = FoodSelectionViewController()
        foodSelectionVC.deliveryAddressEntered = newAddress
        
        
        self.present (foodSelectionVC, animated: true, completion: nil)
        
        textField.text = "\(textField.text!)"
        return false
    }
    
}

extension DeliveryAddressViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deliveryAddress = viewModel.deliveryAddresses[indexPath.row].deliveryAddress
        let deliveryAddressSelected = deliveryAddress
        didSelectFoodSelection(deliveryAddress: deliveryAddressSelected)
        print("Value: \(deliveryAddressSelected)")
    }
    
}

extension DeliveryAddressViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliveryAddressCell = tableView.dequeueReusableCell(withIdentifier: "deliveryAddressCell", for: indexPath as IndexPath)
        
        let deliveryAddress = viewModel.deliveryAddresses[indexPath.row]
        
        deliveryAddressCell.textLabel!.text = "\(deliveryAddress.deliveryAddress)"
        
        return deliveryAddressCell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.deliveryAddresses.count
    }
}