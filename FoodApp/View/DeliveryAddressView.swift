//
//  DeliveryAddressView.swift
//  FoodApp
//
//  Created by hu tsun hao on 17/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

protocol DeliveryAddressViewDelegate: NSObjectProtocol {
    func foodSelectionSwitch(deliveryAddress: String)
}

let deliveryAddressVC = DeliveryAddressViewController()

class DeliveryAddressView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var deliveryAddressViewDelegate: DeliveryAddressViewDelegate?
    
    var deliveryAddressEntered: String = ""
    
    var shouldSetupConstraints = true
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
    
    // table view
    
    var deliveryAddressArray = ["Current Location","Past Location 1", "Past Location 2"]
    var deliveryAddressTableView = UITableView()
    let cellHeight = 50
    
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


    //----------------------------------------------------//
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(naviBar)
        self.addSubview(deliveryAddressTextField)
        
        //tableview setup
        deliveryAddressTableView.rowHeight = 50
        self.addSubview(deliveryAddressTableView)
        
        deliveryAddressTableView.delegate = self
        deliveryAddressTableView.dataSource = mainView
        deliveryAddressTableView.register(UITableViewCell.self, forCellReuseIdentifier: "deliveryAddressCell")

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
           naviBarConstraint()
           deliveryAddressTextFieldConstraints()
           deliveryAddressTableViewConstraints()
        }
        super.updateConstraints()
    }
    
    
    //----------------------------------------------------//
    // MARK: Constraints
    
    // navi bar
    func naviBarConstraint (){
        constrain (naviBar, self) { navi, view in
        navi.width == view.width
        navi.height == 65
        navi.top == view.top
        navi.centerX == view.centerX
        }
    }
    
    // text field
    func deliveryAddressTextFieldConstraints() {
        constrain(deliveryAddressTextField,naviBar){ deliveryAddressTF, naviBar in
            deliveryAddressTF.width == naviBar.width
            deliveryAddressTF.height == 40
            deliveryAddressTF.centerX == naviBar.superview!.centerX
            deliveryAddressTF.top == naviBar.bottom - 25
        }
    }
    
    // table view

    func deliveryAddressTableViewConstraints(){
                deliveryAddressTableView.backgroundColor = UIColor.blue
        let tableViewHight = CGFloat(deliveryAddressArray.count * cellHeight)
        constrain(deliveryAddressTableView, deliveryAddressTextField) { deliveryAddressTV, deliveryAddressTF in
            deliveryAddressTV.width == deliveryAddressTF.width
            deliveryAddressTV.centerX == deliveryAddressTF.superview!.centerX
            deliveryAddressTV.height == tableViewHight
            deliveryAddressTV.top == deliveryAddressTF.bottom
        }
        
    }
    
    
    //----------------------------------------------------//
    // MARK: Screen dismiss setup
    @objc func backPressed (){
        let currentController = self.getCurrentViewController()
        currentController?.dismiss(animated: true, completion: nil)

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
    
    
    //----------------------------------------------------//
    // MARK: TableView setup
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deliveryAddressCell = tableView.dequeueReusableCell(withIdentifier: "deliveryAddressCell", for: indexPath as IndexPath)
        print("Num: \(indexPath.row)")
        
        let deliveryAddressSelected = deliveryAddressArray[indexPath.row]
        foodSelectionSwitch(_sender: deliveryAddressCell, deliveryAddress: deliveryAddressSelected)
        print("Value: \(deliveryAddressArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryAddressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliveryAddressCell = tableView.dequeueReusableCell(withIdentifier: "deliveryAddressCell", for: indexPath as IndexPath)
        deliveryAddressCell.textLabel!.text = "\(deliveryAddressArray[indexPath.row])"
        return deliveryAddressCell
    }
    
    //----------------------------------------------------//
    // MARK: Page change setup
    
    @objc func foodSelectionSwitch (_sender: UITableViewCell! ,deliveryAddress: String) {
        deliveryAddressViewDelegate?.foodSelectionSwitch(deliveryAddress: deliveryAddress)
    }
    

}
