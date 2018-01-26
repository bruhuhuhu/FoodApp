//
//  FoodSelectionViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 19/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

var foodSelectionView: FoodSelectionView!

class FoodSelectionViewController: UIViewController {



var deliveryAddressEntered: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
 
    foodSelectionView = FoodSelectionView(frame: CGRect.zero)
    
        self.navigationItem.title = deliveryAddressEntered
       
        foodSelectionView.deliveryAddressEntered = deliveryAddressEntered
        
        // Autolayout ---- to be edited for iphone x
        self.view.addSubview(foodSelectionView)
        constrain (foodSelectionView) { foodSelectionView in
            foodSelectionView.left == foodSelectionView.superview!.left
            foodSelectionView.right == foodSelectionView.superview!.right
        }
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                foodSelectionView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0), foodSelectionView.bottomAnchor.constraintEqualToSystemSpacingBelow(guide.bottomAnchor, multiplier: 1.0)
                ])
            
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                foodSelectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo: foodSelectionView.bottomAnchor, constant: standardSpacing)
                ])
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
