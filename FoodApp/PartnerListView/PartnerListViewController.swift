//
//  PartnerListViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 19/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

var partnerListView : PartnerListView!


class PartnerListViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.purple
        
        partnerListView = PartnerListView(frame: CGRect.zero)
        
        // Autolayout
        self.view.addSubview(partnerListView)
        constrain (partnerListView) { partnerListView in
            partnerListView.left == partnerListView.superview!.left
            partnerListView.right == partnerListView.superview!.right
        }
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                partnerListView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0), partnerListView.bottomAnchor.constraintEqualToSystemSpacingBelow(guide.bottomAnchor, multiplier: 1.0)
                ])
            
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                partnerListView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo: partnerListView.bottomAnchor, constant: standardSpacing)
                ])
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
