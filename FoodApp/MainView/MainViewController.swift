//
//  MainViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 16/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography


class MainViewController: UIViewController {

    // MARK: - Define the UI elements
    
    lazy var viewModel = MainViewModel()
    
    var naviBar : UINavigationBar! = {
        let naviBar = UINavigationBar()
        let navItem = UINavigationItem();
        let backBtn = UIBarButtonItem (barButtonSystemItem: .stop, target: self, action: nil)
        navItem.leftBarButtonItem = backBtn
        naviBar.setItems([navItem], animated: false);
        
        return naviBar
    }()
    
    let takeAwayLabel: UILabel! = {
        let label = UILabel()
        label.text = "TAKE AWAY"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28)
        
        return label
    }()
    
    let takeAwaySubLabel: UILabel = {
        let label = UILabel()
        label.text = "Find the best takeaway food and service"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    let partnerLabel: UILabel! = {
        let label = UILabel()
        label.text = "Or proceed straight to our partner stores"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()

    
    let deliveryAddressButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didSelectDeliveryAddressButton), for: .touchDown)
        button.setTitle("Enter Delivery Address", for: .normal)
        button.backgroundColor = UIColor.black
        
        return button
    }()
    
    
    let partnerListButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didSelectPartnerListButton), for: .touchDown)
        button.setTitle("v", for: .normal)
        
        return button
    }()
    
    let cellHeight = 50
    var deliveryAddressTableView = UITableView()
    

    // MARK: - Setup
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.lightGray
        viewModel.getDeliveryAddress()
        setupView()
        updateConstraints()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupView() {
        deliveryAddressTableView.rowHeight = 50
        deliveryAddressTableView.delegate = self
        deliveryAddressTableView.dataSource = self
        deliveryAddressTableView.register(UITableViewCell.self, forCellReuseIdentifier: "deliveryAddressCell")
        
        self.view.addSubview(naviBar)
        self.view.addSubview(takeAwayLabel)
        self.view.addSubview(takeAwaySubLabel)
        self.view.addSubview(deliveryAddressButton)
        self.view.addSubview(partnerLabel)
        self.view.addSubview(partnerListButton)
        self.view.addSubview(deliveryAddressTableView)
    }
    
    
    func updateConstraints() {
        naviBarConstraint()
        takeAwayLabelConstraint ()
        takeAwaySubLabelConstraint()
        deliveryAddressTableViewConstraint()
        partnerListButtonConstraint()
        partnerLabelConstraint()
        deliveryAddressButtonConstraint()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getDeliveryAddress()
        deliveryAddressTableView.reloadData()
    }
    
    // MARK: - Constraints
    
    func deliveryAddressTableViewConstraint(){
        constrain(deliveryAddressTableView, deliveryAddressButton) { deliveryAddressTV, deliveryAddressBtn in
            deliveryAddressTV.width == deliveryAddressBtn.width
            deliveryAddressTV.height == 150
            deliveryAddressTV.centerX == deliveryAddressBtn.superview!.centerX
            deliveryAddressTV.top == deliveryAddressBtn.bottom + 4
        }
        
    }
    
    func partnerListButtonConstraint (){
        constrain(partnerListButton, self.view){partnerListBtn, view in
            partnerListBtn.width == 24
            partnerListBtn.height == 24
            partnerListBtn.bottom == view.bottom - 72
            partnerListBtn.centerX == view.centerX
            partnerListButton.backgroundColor = UIColor.blue
        }
    }
    
    func naviBarConstraint (){
        constrain (naviBar, self.view) { navi, view in
            navi.width == view.width
            navi.height == 65
            navi.top == topLayoutGuideCartography
            navi.centerX == view.centerX
        }
    }
    
    func takeAwayLabelConstraint (){
        constrain(takeAwayLabel, self.view){label, view in
            label.width == 164
            label.height == 34
            label.top == view.top + 134
            label.left == view.left + 24
        }
    }
    
    func takeAwaySubLabelConstraint (){
        constrain(takeAwaySubLabel,takeAwayLabel){subLabel, mainLabel in
            subLabel.width == 315
            subLabel.height == 16
            subLabel.left == mainLabel.left
            subLabel.top == mainLabel.bottom + 8
        }
    }
    
    func partnerLabelConstraint (){
        constrain(partnerLabel,partnerListButton){partnerLabel, partnerListBtn in
            partnerLabel.width == 237
            partnerLabel.height == 14
            partnerLabel.centerX == partnerListBtn.superview!.centerX
            partnerLabel.top == partnerListBtn.bottom + 8
        }
    }
    
    func deliveryAddressButtonConstraint() {
        constrain(deliveryAddressButton,takeAwaySubLabel){ deliveryAddressBtn, subLabel in
            deliveryAddressBtn.width == 359
            deliveryAddressBtn.height == 48
            deliveryAddressBtn.centerX == subLabel.superview!.centerX
            deliveryAddressBtn.top == subLabel.bottom + 129
        }
    }
    
    
    // MARK: - Did Select
    
    
    // MARK: Switch to Partner List View
  @objc func didSelectPartnerListButton() {
        let partnerListVC = PartnerListViewController()
        self.present (partnerListVC, animated: true, completion: nil)
    }
    
  @objc func didSelectDeliveryAddress(deliveryAddress: String) {
        let foodSelectionVC = FoodSelectionViewController()
        foodSelectionVC.deliveryAddressEntered = deliveryAddress
        self.present (foodSelectionVC, animated: true, completion: nil)
    }
    
    @objc func didSelectDeliveryAddressButton() {
        let  deliveryAddressVC = DeliveryAddressViewController()
        self.present (deliveryAddressVC, animated: true, completion: nil)
    }
    
}




extension MainViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deliveryAddress = viewModel.deliveryAddresses[indexPath.row].deliveryAddress
        let deliveryAddressSelected = deliveryAddress
        didSelectDeliveryAddress(deliveryAddress: deliveryAddressSelected)
        print("Value: \(deliveryAddressSelected)")
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.deliveryAddresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliveryAddressCell = tableView.dequeueReusableCell(withIdentifier: "deliveryAddressCell", for: indexPath as IndexPath)
        
        let deliveryAddress = viewModel.deliveryAddresses[indexPath.row]
        
        deliveryAddressCell.textLabel!.text = "\(deliveryAddress.deliveryAddress)"
        
        return deliveryAddressCell
    }
    
}
