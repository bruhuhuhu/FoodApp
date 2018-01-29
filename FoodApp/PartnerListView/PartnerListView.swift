//
//  PartnerListView.swift
//  FoodApp
//
//  Created by hu tsun hao on 19/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

let partnerListVC = PartnerListViewController()

class PartnerListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var shouldSetupConstraints = true
    
    //----------------------------------------------------//
    // MARK: Define the UI elements
    
    // navi bar
    
    var naviBar : UINavigationBar! = {
        
        //let nav = UINavigationController (rootViewController: deliveryVC)
        let naviBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Select Partner Store");
        let backBtn = UIBarButtonItem (barButtonSystemItem: .stop, target: self, action: #selector (backPressed))
        navItem.leftBarButtonItem = backBtn
        naviBar.setItems([navItem], animated: false);
        return naviBar
    }()
    
    // table view
    
    var partnerListArray: NSArray = ["Food Panda","UberEATS", "Deliveroo", "Spizza"]

    
    var partnerListTableView = UITableView()

        let cellHeight = 124
    
    
    
    //----------------------------------------------------//
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(naviBar)
        self.addSubview(partnerListTableView)
        
        partnerListTableView.delegate = self
        partnerListTableView.dataSource = self
        partnerListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "partnerListCell")

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            naviBarConstraint()
            partnerListTableViewConstraint()
        }
        super.updateConstraints()
    }
    
    //----------------------------------------------------//
    // MARK: Constraints
    
    // navi bar
    func naviBarConstraint (){
        constrain (naviBar, self) { navi, view in
            navi.width == view.width
            navi.height == 65
            navi.top == view.top
            navi.centerX == view.centerX
        }
    }
    
    // table view
    func partnerListTableViewConstraint(){
        
        constrain(partnerListTableView, naviBar) { partnerListTV, naviBar in

            partnerListTV.width == naviBar.width
            partnerListTV.bottom == (naviBar.superview?.bottom)! - 20
            partnerListTV.centerX == naviBar.superview!.centerX
            partnerListTV.top == naviBar.bottom + 4
        }
        
    }
    
    
    
    //----------------------------------------------------//
    // MARK: Screen dismiss setup
    @objc func backPressed (){
        let currentController = self.getCurrentViewController()
        currentController?.dismiss(animated: true, completion: nil)
        
    }
    
    func getCurrentViewController() -> UIViewController? {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
    
    
    //----------------------------------------------------//
    // MARK: TableView setup
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(partnerListArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partnerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let partnerListCell = tableView.dequeueReusableCell(withIdentifier: "partnerListCell", for: indexPath as IndexPath)
        partnerListCell.textLabel!.text = "\(partnerListArray[indexPath.row])"
        return partnerListCell
    }
    
}
