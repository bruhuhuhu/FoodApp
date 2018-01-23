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
        self.view.addSubview(foodSelectionView)
        foodSelectionView.deliveryAddressEntered = deliveryAddressEntered
        

        
        constrain (foodSelectionView) { foodSelectionView in
            foodSelectionView.edges == inset (foodSelectionView.superview!.edges, 50,0,0,0)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
