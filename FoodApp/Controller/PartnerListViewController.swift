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
        
        self.view.addSubview(partnerListView)
        constrain (partnerListView) { partnerListView in
            partnerListView.edges == inset (partnerListView.superview!.edges, 50,0,0,0)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
