//
//  MainViewTableViewCell.swift
//  FoodApp
//
//  Created by hu tsun hao on 1/2/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//


import UIKit
import Foundation
import Cartography

class MainViewTableViewCell : UITableViewCell {
    
    
    let deliveryAddressLabel = UILabel()
    //let deliveryBuildingLabel = UILabel()
    let postalCodeLabel = UILabel()
    let historyIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "history")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let rightChevronIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "browserForward")
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
        contentView.addSubview(postalCodeLabel)
        contentView.addSubview(rightChevronIcon)
    }
    
    func updateCellConstraints(){
        
        //deliveryBuildingLabel.numberOfLines = 0
        deliveryAddressLabel.numberOfLines = 0
        
        constrain (contentView, deliveryAddressLabel, historyIcon ){ view, deliveryAddressLbl, historyIcon in
            historyIcon.centerY == view.centerY
            historyIcon.left == view.leftMargin + 12
            
            deliveryAddressLbl.leading == historyIcon.trailing + 11
            deliveryAddressLbl.top == view.top + 15
            deliveryAddressLbl.bottom == view.bottom - 15
            
        }
        
        constrain (contentView , postalCodeLabel, rightChevronIcon ) { view , postalCodeLbl ,rightChevronIcon in
            rightChevronIcon.centerY == view.centerY
            rightChevronIcon.trailing == view.trailing - 12
            postalCodeLbl.centerY == view.centerY
            postalCodeLbl.trailing == rightChevronIcon.leading - 6
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
