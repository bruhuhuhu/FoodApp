//
//  FoodSelectionView.swift
//  FoodApp
//
//  Created by hu tsun hao on 19/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import UIKit
import Cartography
let foodSelectionVC = FoodSelectionViewController()



class FoodSelectionView: UIView {

    
    var shouldSetupConstraints = true
    var deliveryAddressEntered : String = ""


//    //----------------------------------------------------//
//    // MARK: Define the UI elements
//
//    // navi bar
//
//    var naviBar : UINavigationBar! = {
//
//        let naviBar = UINavigationBar()
//        let backBtn = UIBarButtonItem (barButtonSystemItem: .stop, target: self, action: #selector (backPressed))
//        let cartBtn = UIBarButtonItem (barButtonSystemItem: .bookmarks, target: self, action: nil)
//        let navItem = UINavigationItem();
//        navItem.leftBarButtonItem = backBtn
//        navItem.rightBarButtonItem = cartBtn
//        naviBar.setItems([navItem], animated: false);
//        return naviBar
//    }()
//
//    // filter bar
//
//    var filterBar : UIToolbar! = {
//
//        let filterBar = UIToolbar()
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil);
//        let fastestBtn = UIBarButtonItem (title: "Fastest", style: .plain, target: self, action: nil)
//        let allTasteBtn = UIBarButtonItem (title: "All Tastes", style: .plain, target: self, action: nil)
//         let refineBtn = UIBarButtonItem (title: "Refine Results", style: .plain, target: self, action: nil)
//        let seperatorLine = UIBarButtonItem(title: "|", style: .plain ,target: self, action: nil)
//        var filterItems = [UIBarButtonItem]()
//        filterBar.items = [refineBtn,flexibleSpace,fastestBtn,seperatorLine,allTasteBtn]
//
//        return filterBar
//    }()
//
//
//    // table view
//
//    var foodSelectionArray: NSArray = ["Food item 1","Food item 2", "Food item 3", "Food item 4"]
//    var foodSelectionTableView = UITableView()
//    let cellHeight = 124
//
//
//    // collection view
//    let noticeCollectionViewLayout = UICollectionViewFlowLayout.init()
//    var noticeCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout.init())
//    var noticeArray = ["this is page 1", "this is page 2", "this is page 3"]

    
    
    //----------------------------------------------------//
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
//        noticeCollectionViewLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
//        noticeCollectionView.isPagingEnabled = true
//        noticeCollectionView.setCollectionViewLayout(noticeCollectionViewLayout, animated: true)
//
//        noticeCollectionView.delegate = self
//        noticeCollectionView.dataSource = self
//        noticeCollectionView.register(FoodSelectionNoticeCollectionViewCell.self, forCellWithReuseIdentifier: "pages")
//
//
//        self.addSubview(noticeCollectionView)
//        self.addSubview(naviBar)
//        self.addSubview(foodSelectionTableView)
//        self.addSubview(filterBar)
//
//        foodSelectionTableView.delegate = self
//        foodSelectionTableView.dataSource = self
//        foodSelectionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "partnerListCell")
//
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    
//    override func updateConstraints() {
//        if(shouldSetupConstraints) {
//            naviBarConstraint()
//            foodSelectionTableViewConstraint()
//            filterBarConstraint()
//            noticeCollectionViewConstraint()
//        }
//        super.updateConstraints()
//    }
    
//    //----------------------------------------------------//
//    // MARK: Constraints
//
//    // navi bar
//    func naviBarConstraint (){
//        naviBar.topItem?.title = "Deliver to \(deliveryAddressEntered)"
//        constrain (naviBar, self) { naviBar, view in
//            naviBar.width == view.width
//            naviBar.height == 65
//            naviBar.top == view.top
//            naviBar.centerX == view.centerX
//
//        }
//    }
//
//    // filter bar
//    func filterBarConstraint(){
//        constrain(filterBar, naviBar) { filterBar, naviBar in
//            filterBar.width == naviBar.width
//            filterBar.height == 40
//            filterBar.top == naviBar.bottom - 25
//            filterBar.centerX == naviBar.superview!.centerX
//        }
//
//    }
//
//
//
//    // table view
//    func foodSelectionTableViewConstraint(){
//
//        constrain(foodSelectionTableView, noticeCollectionView) { foodSelectionTV, filterBar in
//
//            foodSelectionTV.width == filterBar.width
//            foodSelectionTV.bottom == (filterBar.superview?.bottom)! - 20
//            foodSelectionTV.height == 300
//            foodSelectionTV.centerX == filterBar.superview!.centerX
//            foodSelectionTV.top == filterBar.bottom + 4
//        }
//
//    }
//
//    //collection view
//
//    func noticeCollectionViewConstraint(){
//        //noticeCollectionView.backgroundColor = UIColor.orange
//        constrain (noticeCollectionView, filterBar){ noticeCV, filterBar in
//            noticeCV.width == filterBar.width
//            noticeCV.height == 91
//            noticeCV.centerX == filterBar.superview!.centerX
//            noticeCV.top == filterBar.bottom + 4
//        }
//    }
//
//    //----------------------------------------------------//
//    // MARK: Screen dismiss setup
//    @objc func backPressed (){
//        let currentController = self.getCurrentViewController()
//        currentController?.dismiss(animated: true, completion: nil)
//
//    }
//
//    func getCurrentViewController() -> UIViewController? {
//        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
//            var currentController: UIViewController! = rootController
//            while( currentController.presentedViewController != nil ) {
//                currentController = currentController.presentedViewController
//            }
//            return currentController
//        }
//        return nil
//    }
//
//
//    //----------------------------------------------------//
//    // MARK: TableView setup
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(foodSelectionArray[indexPath.row])")
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return foodSelectionArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let partnerListCell = tableView.dequeueReusableCell(withIdentifier: "partnerListCell", for: indexPath as IndexPath)
//        partnerListCell.textLabel!.text = "\(foodSelectionArray[indexPath.row])"
//        return partnerListCell
//    }
//
//    //----------------------------------------------------//
//    // MARK: CollectionView setup
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        print ("number of pages is \(noticeArray.count)")
//        return noticeArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let noticeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pages", for: indexPath as IndexPath) as! FoodSelectionNoticeCollectionViewCell
//        noticeCell.label.text = "\(noticeArray[indexPath.row])"
//        return noticeCell
//    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout noticeCollectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 375, height: 91)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }


}
