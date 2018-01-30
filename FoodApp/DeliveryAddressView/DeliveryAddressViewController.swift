//
//  DeliveryAddressViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 17/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography



class DeliveryAddressViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    private var viewModel = DeliveryAddressViewModel()
    
    let mainVC = MainViewController()

    
    //----------------------------------------------------//
    // MARK: Define the UI elements
    
    // navi bar
    
    var naviBar : UINavigationBar! = {
        
        //let nav = UINavigationController (rootViewController: deliveryVC)
        let naviBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Deliver Food To");
        let backBtn = UIBarButtonItem (barButtonSystemItem: .stop, target: self, action: #selector (backPressed))
        navItem.leftBarButtonItem = backBtn
        naviBar.setItems([navItem], animated: false);
        return naviBar
    }()
    
    
    // text field
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
    
    
    // table view
    
//    var deliveryAddressArray = ["Current Location","Past Location 1", "Past Location 2"]
    var deliveryAddressTableView = UITableView()
    let cellHeight = 50
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deliveryAddressTextField.text = viewModel.address
        self.deliveryAddressTextField.delegate = self
        
        
        // Background
        self.view.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(naviBar)
        
        self.view.addSubview(deliveryAddressTextField)
        
        //tableview setup
        self.deliveryAddressTableView.rowHeight = 50
        self.view.addSubview(deliveryAddressTableView)
        
        
        
        deliveryAddressTableView.delegate = self
        deliveryAddressTableView.dataSource = mainVC
        deliveryAddressTableView.register(UITableViewCell.self, forCellReuseIdentifier: "deliveryAddressCell")
        
        updateConstraints()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let deliveryAddress = textField.text!
        mainVC.deliveryAddressArray.append(deliveryAddress)
        print ("the array count is \(mainVC.deliveryAddressArray.count)")
        
        self.deliveryAddressTableView.reloadData()
      
        //change view to second screen after return is clicked
        let foodSelectionVC = FoodSelectionViewController()
        foodSelectionVC.deliveryAddressEntered = deliveryAddress
        self.present (foodSelectionVC, animated: true, completion: nil)
        
        
        textField.text = "\(textField.text!)"
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func foodSelectionSwitch(deliveryAddress: String) {
        let foodSelectionVC = FoodSelectionViewController()
        foodSelectionVC.deliveryAddressEntered = deliveryAddress
        self.present (foodSelectionVC, animated: true, completion: nil)
    }
    
    // MARK: - constraints
    
    func updateConstraints(){
        naviBarConstraint()
        deliveryAddressTextFieldConstraint()
        deliveryAddressTableViewConstraint()
    }
    
    // navi bar
    func naviBarConstraint (){
        constrain (naviBar, self.view) { navi, view in
            navi.width == view.width
            navi.height == 65
            navi.top == topLayoutGuideCartography
            navi.centerX == view.centerX
        }
    }
    
    // text field
    func deliveryAddressTextFieldConstraint() {
        constrain(deliveryAddressTextField,naviBar){ deliveryAddressTF, naviBar in
            deliveryAddressTF.width == naviBar.width
            deliveryAddressTF.height == 40
            deliveryAddressTF.centerX == naviBar.superview!.centerX
            deliveryAddressTF.top == naviBar.bottom - 25
        }
    }
    
    
    // table view
    
    func deliveryAddressTableViewConstraint(){
        deliveryAddressTableView.backgroundColor = UIColor.blue
        let tableViewHight = CGFloat(mainVC.deliveryAddressArray.count * cellHeight)
        constrain(deliveryAddressTableView, deliveryAddressTextField) { deliveryAddressTV, deliveryAddressTF in
            deliveryAddressTV.width == deliveryAddressTF.width
            deliveryAddressTV.centerX == deliveryAddressTF.superview!.centerX
            deliveryAddressTV.height == tableViewHight
            deliveryAddressTV.top == deliveryAddressTF.bottom
        }
        
    }
    
    
    //----------------------------------------------------//
    // MARK: TableView setup
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deliveryAddressCell = tableView.dequeueReusableCell(withIdentifier: "deliveryAddressCell", for: indexPath as IndexPath)
        print("Num: \(indexPath.row)")
        
        let deliveryAddressSelected = mainVC.deliveryAddressArray[indexPath.row]
        foodSelectionSwitch(deliveryAddress: deliveryAddressSelected)
        print("Value: \(mainVC.deliveryAddressArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVC.deliveryAddressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliveryAddressCell = tableView.dequeueReusableCell(withIdentifier: "deliveryAddressCell", for: indexPath as IndexPath)
        deliveryAddressCell.textLabel!.text = "\(mainVC.deliveryAddressArray[indexPath.row])"
        return deliveryAddressCell
    }
    
    
    
    // MARK: Screen dismiss setup
    @objc func backPressed (){
        let currentController = self.getCurrentViewController()
        currentController?.dismiss(animated: true, completion: nil)
          mainVC.deliveryAddressTableView.reloadData()
        
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
