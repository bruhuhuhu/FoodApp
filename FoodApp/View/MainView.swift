//
//  MainView.swift
//  FoodApp
//
//  Created by hu tsun hao on 16/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography


protocol MainViewDelegate : NSObjectProtocol {
    func partnerListButtonSwitch()
    func deliveryAddressButtonSwitch()
    func deliveryAddressSwitch(deliveryAddress: String)
}


class MainView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var mainViewDelegate: MainViewDelegate?
    
    var shouldSetupConstraints = true
    //----------------------------------------------------//
    // MARK: Define the UI elements
    
    // navi bar
    
    var naviBar : UINavigationBar! = {
        
        //let nav = UINavigationController (rootViewController: deliveryVC)
        let naviBar = UINavigationBar()
        let navItem = UINavigationItem();
        let backBtn = UIBarButtonItem (barButtonSystemItem: .stop, target: self, action: nil)
        navItem.leftBarButtonItem = backBtn
        naviBar.setItems([navItem], animated: false);
        return naviBar
    }()
    
    // labels
    let takeAwayLabel: UILabel! = {
        let label = UILabel()
        label.text = "TAKE AWAY"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28)
        
        return label
    }()
    
    let takeAwaySubLabel: UILabel! = {
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
    

    
    // button
    
    let deliveryAddressButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(deliveryAddressButtonSwitch), for: .touchDown)
        button.setTitle("Enter Delivery Address", for: .normal)
        button.backgroundColor = UIColor.black
        
        return button
        
    }()
    
    
    let partnerListButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(partnerListButtonSwitch), for: .touchDown)
        button.setTitle("v", for: .normal)
        
        return button
    }()
    
    // table view
    
    var deliveryAddressArray = ["Current Location","Past Location 1"]
    let cellHeight = 50
  
    var deliveryAddressTableView = UITableView()

    
    
    //----------------------------------------------------//
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(naviBar)
        self.addSubview(takeAwayLabel)
        self.addSubview(takeAwaySubLabel)
        self.addSubview(partnerLabel)
        //self.addSubview(deliveryAddressTextField)
        self.addSubview(partnerListButton)
        self.addSubview(deliveryAddressButton)

        
        //tableview setup
        deliveryAddressTableView.rowHeight = 50
        
        self.addSubview(deliveryAddressTableView)

        deliveryAddressTableView.delegate = self
        deliveryAddressTableView.dataSource = self
        deliveryAddressTableView.register(UITableViewCell.self, forCellReuseIdentifier: "deliveryAddressCell")

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
        naviBarConstraint()
        takeAwayLabelConstraint ()
        takeAwaySubLabelConstraint()
        deliveryAddressTableViewConstraint()
        partnerListButtonConstraint()
        partnerLabelConstraint()
        deliveryAddressButtonConstraint()
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
    
    // button
    
    func deliveryAddressButtonConstraint() {
        constrain(deliveryAddressButton,takeAwaySubLabel){ deliveryAddressBtn, subLabel in
            deliveryAddressBtn.width == 359
            deliveryAddressBtn.height == 48
            deliveryAddressBtn.centerX == subLabel.superview!.centerX
            deliveryAddressBtn.top == subLabel.bottom + 129
        }
    }

    func partnerListButtonConstraint (){
        constrain(partnerListButton, self){partnerListBtn, view in
            partnerListBtn.width == 24
            partnerListBtn.height == 24
            partnerListBtn.bottom == view.bottom - 72
            partnerListBtn.centerX == view.centerX
            partnerListButton.backgroundColor = UIColor.blue
        }
    }
    
    // labels
    
    func takeAwayLabelConstraint (){
        constrain(takeAwayLabel, self){label, view in
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

    // table view
    func deliveryAddressTableViewConstraint(){
    
        constrain(deliveryAddressTableView, deliveryAddressButton) { deliveryAddressTV, deliveryAddressBtn in
            
//          let tableViewHeight = CGFloat(deliveryAddressArray.count * cellHeight)
            
            deliveryAddressTV.width == deliveryAddressBtn.width
            deliveryAddressTV.height == 150
            deliveryAddressTV.centerX == deliveryAddressBtn.superview!.centerX
            deliveryAddressTV.top == deliveryAddressBtn.bottom + 4
        }
        
    }
    
    
    //----------------------------------------------------//
    // MARK: TableView setup
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        let deliveryAddressCell = tableView.dequeueReusableCell(withIdentifier: "deliveryAddressCell", for: indexPath as IndexPath)

        let deliveryAddressSelected = deliveryAddressArray[indexPath.row]
        deliveryAddressSwitch(_sender: deliveryAddressCell, deliveryAddress: deliveryAddressSelected)
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
    
    @objc func partnerListButtonSwitch(_sender: UIButton!) {
        mainViewDelegate?.partnerListButtonSwitch()
    }
    
    @objc func deliveryAddressButtonSwitch(_sender: UIButton){
        mainViewDelegate?.deliveryAddressButtonSwitch()
        
    }
    
    @objc func deliveryAddressSwitch (_sender: UITableViewCell! ,deliveryAddress: String) {
        mainViewDelegate?.deliveryAddressSwitch(deliveryAddress: deliveryAddress)
    }
}

