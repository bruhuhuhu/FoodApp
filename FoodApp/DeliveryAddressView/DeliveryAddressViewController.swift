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
        let backBtn = UIBarButtonItem (image: #imageLiteral(resourceName: "browserBackward"), style: .done , target: self, action: #selector (didSelectBackButton))
        //let backBtn = UIBarButtonItem (barButtonSystemItem: .stop, target: self, action: #selector (didSelectBackButton))
        navItem.leftBarButtonItem = backBtn
        naviBar.setItems([navItem], animated: false);
        return naviBar
    }()
    
    let deliveryAddressTextField: UITextField! = {
        
        let textField = UITextField()
        let leftImage = UIImageView()
        
        leftImage.image = #imageLiteral(resourceName: "search")
        let contentView = UIView()
        contentView.addSubview(leftImage)
        contentView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        leftImage.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        textField.leftView = contentView
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftViewMode = .always
        //textField.leftView = UIImageView(image: #imageLiteral(resourceName: "magnifying-glass"))
        
        textField.placeholder = "   Enter delivery address or zip code"
        //textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.text = ""
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    let cellHeight = 50
    var deliveryAddressTableView = UITableView()

    
    // MARK: - Setup
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        viewModel.getDeliveryAddress()
        setupView()
        paintUI()
        updateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func paintUI() {
        naviBar.backgroundColor = UIColor.white
        naviBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red:0.29, green:0.32, blue:0.39, alpha:1.0)]
        deliveryAddressTextField.backgroundColor = UIColor(red:0.99, green:0.99, blue:0.99, alpha:1.0)
        deliveryAddressTableView.backgroundColor =
            UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        deliveryAddressTableView.separatorStyle = .none
        
    }
    
    func setupView() {

        
        deliveryAddressTableView.delegate = self
        deliveryAddressTableView.dataSource = self
        deliveryAddressTableView.register(DeliveryAddressTableViewCell.self, forCellReuseIdentifier: "deliveryAddressCell")
        //deliveryAddressTableView.register(UITableViewCell.self, forCellReuseIdentifier: "deliveryAddressCell")
        self.deliveryAddressTextField.text = deliveryAddressEntered
        self.deliveryAddressTextField.delegate = self
        self.deliveryAddressTableView.estimatedRowHeight = 50
        self.deliveryAddressTableView.rowHeight = UITableViewAutomaticDimension
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
        constrain(deliveryAddressTableView, deliveryAddressTextField) { deliveryAddressTV, deliveryAddressTF in
            deliveryAddressTV.width == deliveryAddressTF.width
            deliveryAddressTV.centerX == deliveryAddressTF.superview!.centerX
            deliveryAddressTV.bottom == deliveryAddressTF.superview!.bottom
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
        //textField.text = "\(textField.text!)"
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
        let deliveryAddressCell = tableView.dequeueReusableCell(withIdentifier: "deliveryAddressCell", for: indexPath as IndexPath) as! DeliveryAddressTableViewCell
        
        let deliveryAddress = viewModel.deliveryAddresses[indexPath.row]
        deliveryAddressCell.deliveryAddressLabel.text = deliveryAddress.deliveryAddress
        deliveryAddressCell.deliveryBuildingLabel.text = "this is a test building"
        deliveryAddressCell.postalCodeLabel.text = "123321"
        
        return deliveryAddressCell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.deliveryAddresses.count
    }
}
