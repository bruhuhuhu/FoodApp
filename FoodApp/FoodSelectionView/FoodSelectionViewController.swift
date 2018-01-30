//
//  FoodSelectionViewController.swift
//  FoodApp
//
//  Created by hu tsun hao on 19/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography


class FoodSelectionViewController: UIViewController{

    var deliveryAddressEntered: String = ""

    // MARK: Define the UI elements

    var naviBar : UINavigationBar! = {
        
        let naviBar = UINavigationBar()
        let backBtn = UIBarButtonItem (barButtonSystemItem: .stop, target: self, action: #selector (backPressed))
        let cartBtn = UIBarButtonItem (barButtonSystemItem: .bookmarks, target: self, action: nil)
        let navItem = UINavigationItem();
        navItem.leftBarButtonItem = backBtn
        navItem.rightBarButtonItem = cartBtn
        naviBar.setItems([navItem], animated: false);
        return naviBar
    }()
    
    var filterBar : UIToolbar! = {
        
        let filterBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil);
        let fastestBtn = UIBarButtonItem (title: "Fastest", style: .plain, target: self, action: nil)
        let allTasteBtn = UIBarButtonItem (title: "All Tastes", style: .plain, target: self, action: nil)
        let refineBtn = UIBarButtonItem (title: "Refine Results", style: .plain, target: self, action: nil)
        let seperatorLine = UIBarButtonItem(title: "|", style: .plain ,target: self, action: nil)
        var filterItems = [UIBarButtonItem]()
        filterBar.items = [refineBtn,flexibleSpace,fastestBtn,seperatorLine,allTasteBtn]
        
        return filterBar
    }()
    

    
    var foodSelectionArray: NSArray = ["Food item 1","Food item 2", "Food item 3", "Food item 4"]
    var foodSelectionTableView = UITableView()
    let cellHeight = 124
    
    let noticeCollectionViewLayout = UICollectionViewFlowLayout.init()
    var noticeCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout.init())
    var noticeArray = ["this is page 1", "this is page 2", "this is page 3"]
    
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        self.navigationItem.title = deliveryAddressEntered
        setupView()
        updateConstraints()
    }
    
    func setupView(){
        noticeCollectionViewLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        noticeCollectionView.isPagingEnabled = true
        noticeCollectionView.setCollectionViewLayout(noticeCollectionViewLayout, animated: true)
        
        noticeCollectionView.delegate = self
        noticeCollectionView.dataSource = self
        noticeCollectionView.register(FoodSelectionNoticeCollectionViewCell.self, forCellWithReuseIdentifier: "pages")
        
        foodSelectionTableView.delegate = self
        foodSelectionTableView.dataSource = self
        foodSelectionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "partnerListCell")
        
        self.view.addSubview(noticeCollectionView)
        self.view.addSubview(naviBar)
        self.view.addSubview(foodSelectionTableView)
        self.view.addSubview(filterBar)
    }
    
    
    func updateConstraints() {
            naviBarConstraint()
            foodSelectionTableViewConstraint()
            filterBarConstraint()
            noticeCollectionViewConstraint()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Constraints

    func naviBarConstraint (){
        naviBar.topItem?.title = "Deliver to \(deliveryAddressEntered)"
        constrain (naviBar, self.view) { naviBar, view in
            naviBar.width == view.width
            naviBar.height == 65
            naviBar.top == topLayoutGuideCartography
            naviBar.centerX == view.centerX
            
        }
    }

    func filterBarConstraint(){
        constrain(filterBar, naviBar) { filterBar, naviBar in
            filterBar.width == naviBar.width
            filterBar.height == 40
            filterBar.top == naviBar.bottom - 25
            filterBar.centerX == naviBar.superview!.centerX
        }
    }

    func foodSelectionTableViewConstraint(){
        
        constrain(foodSelectionTableView, noticeCollectionView) { foodSelectionTV, filterBar in
            
            foodSelectionTV.width == filterBar.width
            foodSelectionTV.bottom == (filterBar.superview?.bottom)! - 20
            foodSelectionTV.height == 300
            foodSelectionTV.centerX == filterBar.superview!.centerX
            foodSelectionTV.top == filterBar.bottom + 4
        }
    }

    
    func noticeCollectionViewConstraint(){
        //noticeCollectionView.backgroundColor = UIColor.orange
        constrain (noticeCollectionView, filterBar){ noticeCV, filterBar in
            noticeCV.width == filterBar.width
            noticeCV.height == 91
            noticeCV.centerX == filterBar.superview!.centerX
            noticeCV.top == filterBar.bottom + 4
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
}

extension FoodSelectionViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(foodSelectionArray[indexPath.row])")
    }
}

extension FoodSelectionViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodSelectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let partnerListCell = tableView.dequeueReusableCell(withIdentifier: "partnerListCell", for: indexPath as IndexPath)
        partnerListCell.textLabel!.text = "\(foodSelectionArray[indexPath.row])"
        return partnerListCell
    }
}

extension FoodSelectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout noticeCollectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 91)
        
    }
}


extension FoodSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        print ("number of pages is \(noticeArray.count)")
        return noticeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let noticeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pages", for: indexPath as IndexPath) as! FoodSelectionNoticeCollectionViewCell
        noticeCell.label.text = "\(noticeArray[indexPath.row])"
        return noticeCell
    }
}

extension FoodSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
