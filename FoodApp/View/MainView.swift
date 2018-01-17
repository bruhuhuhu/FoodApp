//
//  MainView.swift
//  FoodApp
//
//  Created by hu tsun hao on 16/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

class MainView: UIView {
    var shouldSetupConstraints = true
    // define the UI elements
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
    
    
    
    let addressTextField: UITextField! = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.text = "Enter Delivery Address"
        textField.font = .systemFont(ofSize: 15)
        
        return textField
    }()
    //----------------------------------------------------//
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(takeAwayLabel)
        self.addSubview(takeAwaySubLabel)
        self.addSubview(addressTextField)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
        addressTextFieldConstraints()
        takeAwayLabelConstraints ()
        takeAwaySubLabelConstraints()
        }
        super.updateConstraints()
    }
    
    //----------------------------------------------------//
    // constraints
    
    
    // labels
    
    func takeAwayLabelConstraints (){
        constrain(takeAwayLabel, self){label, view in
            label.width == 164
            label.height == 34
            label.top == view.top + 134
            label.left == view.left + 24
            //label.right == view.right - 187
        }
    }
    
    func takeAwaySubLabelConstraints (){
        constrain(takeAwaySubLabel,takeAwayLabel){subLabel, mainLabel in
            subLabel.width == 315
            subLabel.height == 16
            subLabel.left == mainLabel.left
            //subLabel.right == mainLabel.superview!.right - 16
            subLabel.top == mainLabel.bottom + 8
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
    
}
