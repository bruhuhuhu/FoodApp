//
//  OrderConfirmationViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 19/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

var orderConfirmationView: OrderConfirmationView!

class OrderConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.orange
        self.view.addSubview(orderConfirmationView)
        // Autolayout ---- to be edited for iphone x
        self.view.addSubview(orderConfirmationView)
        constrain (orderConfirmationView) { orderConfirmationView in
            orderConfirmationView.left == orderConfirmationView.superview!.left
            orderConfirmationView.right == orderConfirmationView.superview!.right
        }
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                orderConfirmationView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0), orderConfirmationView.bottomAnchor.constraintEqualToSystemSpacingBelow(guide.bottomAnchor, multiplier: 1.0)
                ])
            
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                orderConfirmationView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo:
                    orderConfirmationView.bottomAnchor, constant: standardSpacing)
                ])
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
