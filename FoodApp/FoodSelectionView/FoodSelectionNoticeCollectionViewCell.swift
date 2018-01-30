//
//  FoodSelectionNoticeCell.swift
//  FoodApp
//
//  Created by hu tsun hao on 25/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

class FoodSelectionNoticeCollectionViewCell : UICollectionViewCell {

    var shouldSetupConstraints = true
    var label : UILabel! = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.contentMode = .scaleToFill
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
