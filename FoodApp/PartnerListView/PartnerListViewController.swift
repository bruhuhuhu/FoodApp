//
//  PartnerListViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 19/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography

class PartnerListViewController: UIViewController {

    // MARK: - Define the UI elements
 
    
    var naviBar : UINavigationBar! = {
        
        let naviBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Select Partner Store");
        let backBtn = UIBarButtonItem (barButtonSystemItem: .stop, target: self, action: #selector (didSelectBackButton))
        navItem.leftBarButtonItem = backBtn
        naviBar.setItems([navItem], animated: false);
        return naviBar
    }()

    var partnerListArray: NSArray = ["Food Panda","UberEATS", "Deliveroo", "Spizza"]
    var partnerListTableView = UITableView()
    let cellHeight = 124
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
        setupView()
        updateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        partnerListTableView.delegate = self
        partnerListTableView.dataSource = self
        partnerListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "partnerListCell")
        
        self.view.addSubview(naviBar)
        self.view.addSubview(partnerListTableView)
    }
    
    func updateConstraints() {
            naviBarConstraint()
            partnerListTableViewConstraint()
    }
    
    
    // MARK: -  Constraints
    
    func naviBarConstraint (){
        constrain (naviBar, self.view) { navi, view in
            navi.width == view.width
            navi.height == 65
            navi.top == topLayoutGuideCartography
            navi.centerX == view.centerX
        }
    }
    
    func partnerListTableViewConstraint(){
        
        constrain(partnerListTableView, naviBar) { partnerListTV, naviBar in
            
            partnerListTV.width == naviBar.width
            partnerListTV.bottom == (naviBar.superview?.bottom)! - 20
            partnerListTV.centerX == naviBar.superview!.centerX
            partnerListTV.top == naviBar.bottom + 4
        }
    }
    
    
    // MARK: - Did Select
    
    @objc func didSelectBackButton (){
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
}

extension PartnerListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(partnerListArray[indexPath.row])")
    }
}

extension PartnerListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partnerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let partnerListCell = tableView.dequeueReusableCell(withIdentifier: "partnerListCell", for: indexPath as IndexPath)
        partnerListCell.textLabel!.text = "\(partnerListArray[indexPath.row])"
        return partnerListCell
    }
}
