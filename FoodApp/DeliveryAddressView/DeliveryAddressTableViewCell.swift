//
//  DeliveryAddressTableViewCell.swift
//  FoodApp
//
//  Created by hu tsun hao on 1/2/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//
import UIKit
import Foundation
import Cartography

class DeliveryAddressTableViewCell : UITableViewCell {
    
    
    let deliveryAddressLabel = UILabel()
    let deliveryBuildingLabel = UILabel()
    let postalCodeLabel = UILabel()
    let historyIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "history")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
//    var deliveryAddress : String
//    var deliveryBuilding : String
//    var PostalCode : Int
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        updateCellConstraints()
    }
    
    func setupCell() {
        contentView.addSubview(historyIcon)
        contentView.addSubview(deliveryAddressLabel)
        contentView.addSubview(deliveryBuildingLabel)
        contentView.addSubview(postalCodeLabel)
        
        deliveryAddressLabel.textColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1.0)
        deliveryAddressLabel.font = deliveryAddressLabel.font.withSize(12)
        deliveryBuildingLabel.textColor = UIColor(red:0.29, green:0.32, blue:0.39, alpha:1.0)
        deliveryBuildingLabel.font = deliveryAddressLabel.font.withSize(12)
        postalCodeLabel.textColor =  UIColor(red:0.29, green:0.32, blue:0.39, alpha:1.0)
        postalCodeLabel.font = deliveryAddressLabel.font.withSize(12)
    }
    
    func updateCellConstraints(){

        deliveryBuildingLabel.numberOfLines = 0
        deliveryAddressLabel.numberOfLines = 0
        
        constrain (contentView,deliveryBuildingLabel, deliveryAddressLabel, historyIcon ){ view, deliveryBuildingLbl, deliveryAddressLbl, historyIcon in
            historyIcon.centerY == view.centerY
            historyIcon.left == view.leftMargin + 12
            
            
            deliveryBuildingLbl.top == view.top + 12
            deliveryBuildingLbl.leading == historyIcon.trailing + 11
            
            deliveryAddressLbl.bottom == view.bottom - 12
            deliveryAddressLbl.top == deliveryBuildingLbl.bottom + 3
            deliveryAddressLbl.leading == deliveryBuildingLbl.leading
            
            
        }
        
        constrain (postalCodeLabel, contentView) { postalCodeLbl, view in
            postalCodeLbl.centerY == view.centerY
            postalCodeLbl.trailing == view.trailing - 14
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
