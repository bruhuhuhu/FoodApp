//
//  DeliveryAddressView.swift
//  FoodApp
//
//  Created by hu tsun hao on 17/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

let deliveryVC = DeliveryAddressViewController()

class DeliveryAddressView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    
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
    
    var addressArray: NSArray = ["Current Location","Past Location 1", "Past Location 2"]
    var addressTableView = UITableView()
    
    // text field
    let addressTextField: UITextField! = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.text = "Enter Delivery Address"
        textField.font = .systemFont(ofSize: 15)
        
        return textField
    }()


    //----------------------------------------------------//
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(naviBar)
        self.addSubview(addressTextField)
        
        //tableview setup
        addressTableView.rowHeight = 50
        self.addSubview(addressTableView)
        
        addressTableView.delegate = self
        addressTableView.dataSource = self
        addressTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
           naviBarConstraint()
           addressTextFieldConstraints()
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
    func addressTextFieldConstraints() {
        constrain(addressTextField,naviBar){ addressTF, naviBar in
            addressTF.width == naviBar.width
            addressTF.height == 40
            addressTF.centerX == naviBar.superview!.centerX
            addressTF.top == naviBar.bottom
        }
    }
    
    // table view
    func addressTableViewConstraints(){
        
        constrain(addressTableView, addressTextField) { addressTV, addressTF in
            addressTV.width == addressTF.width
            addressTV.height == 40
            addressTV.centerX == addressTF.superview!.centerX
            addressTV.top == addressTF.bottom
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
        print("Num: \(indexPath.row)")
        print("Value: \(addressArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(addressArray[indexPath.row])"
        return cell
    }

}
