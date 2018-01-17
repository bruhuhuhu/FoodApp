//
//  MainView.swift
//  FoodApp
//
//  Created by hu tsun hao on 16/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

class MainView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var shouldSetupConstraints = true
    //----------------------------------------------------//
    // MARK: Define the UI elements
    
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
    
    // buttons
    let backButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: Selector(("backButtonPressed")), for: .touchDown)
        button.setTitle("<", for: .normal)
        
        return button
    }()
    
    let expandButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: Selector(("expandButtonPressed")), for: .touchDown)
        button.setTitle("v", for: .normal)
        
        return button
    }()
    
    // table view
    
    var addressArray: NSArray = ["Current Location","Past Location 1", "Past Location 2"]
    var addressTableView = UITableView()

    
    
    //----------------------------------------------------//
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(takeAwayLabel)
        self.addSubview(takeAwaySubLabel)
        self.addSubview(partnerLabel)
        self.addSubview(addressTextField)
        self.addSubview(backButton)
        self.addSubview(expandButton)

        
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
        addressTextFieldConstraints()
        takeAwayLabelConstraints ()
        takeAwaySubLabelConstraints()
        addressTableViewConstraints()
        backButtonConstraints()
        expandButtonConstraints()
        partnerLabelConstraints()
        }
        super.updateConstraints()
    }
    
    //----------------------------------------------------//
    // MARK: Constraints
    
    // buttons
    func backButtonConstraints (){
        constrain(backButton, self){backBtn, view in
            backBtn.width == 13
            backBtn.height == 21
            backBtn.top == view.top + 32
            backBtn.left == view.left + 16
        }
    }

    func expandButtonConstraints (){
        constrain(expandButton, self){backBtn, view in
            backBtn.width == 24
            backBtn.height == 24
            backBtn.bottom == view.bottom - 72
            backBtn.centerX == view.centerX
        }
    }
    
    // labels
    
    func takeAwayLabelConstraints (){
        constrain(takeAwayLabel, self){label, view in
            label.width == 164
            label.height == 34
            label.top == view.top + 134
            label.left == view.left + 24
        }
    }
    
    func takeAwaySubLabelConstraints (){
        constrain(takeAwaySubLabel,takeAwayLabel){subLabel, mainLabel in
            subLabel.width == 315
            subLabel.height == 16
            subLabel.left == mainLabel.left
            subLabel.top == mainLabel.bottom + 8
        }
    }
    
    func partnerLabelConstraints (){
        constrain(partnerLabel,expandButton){partnerLabel, expandBtn in
            partnerLabel.width == 237
            partnerLabel.height == 14
            partnerLabel.centerX == expandBtn.superview!.centerX
            partnerLabel.top == expandBtn.bottom + 8
        }
    }
    
    // text field
    func addressTextFieldConstraints() {
        constrain(addressTextField,takeAwaySubLabel){ addressTF, subLabel in
            addressTF.width == 359
            addressTF.height == 48
            addressTF.centerX == subLabel.superview!.centerX
            addressTF.top == subLabel.bottom + 129
        }
    }
    
    // table view
    func addressTableViewConstraints(){

        constrain(addressTableView, addressTextField) { addressTV, addressTF in
            
            addressTV.width == addressTF.width
            addressTV.height == 150
            addressTV.centerX == addressTF.superview!.centerX
            addressTV.top == addressTF.bottom + 4
        }
        
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
