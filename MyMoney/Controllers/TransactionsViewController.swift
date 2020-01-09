//
//  TransactionsViewController.swift
//  MyMoney
//
//  Created by Admin on 08/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import UIKit
import Parchment
import TimelineTableViewCell

class TransactionsViewController: UIViewController {
    
    // TimelinePoint, Timeline back color, title, description, lineInfo, thumbnails, illustration
    let data:[Int: [(TimelinePoint, UIColor, String, String, String?, [String]?, String?)]] = [0:[
            (TimelinePoint(), UIColor.black, "12:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nil, nil, "Sun"),
            (TimelinePoint(), UIColor.black, "15:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nil, nil, "Sun"),
            (TimelinePoint(color: UIColor.green, filled: true), UIColor.green, "16:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", "150 mins", ["Apple"], "Sun"),
            (TimelinePoint(), UIColor.clear, "19:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nil, nil, "Moon")
        ], 1:[
            (TimelinePoint(), UIColor.lightGray, "08:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "60 mins", nil, "Sun"),
            (TimelinePoint(), UIColor.lightGray, "09:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", "30 mins", nil, "Sun"),
            (TimelinePoint(), UIColor.lightGray, "10:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", "90 mins", nil, "Sun"),
            (TimelinePoint(), UIColor.lightGray, "11:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", "60 mins", nil, "Sun"),
            (TimelinePoint(color: UIColor.red, filled: true), UIColor.red, "12:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "30 mins", ["Apple", "Apple", "Apple", "Apple"], "Sun"),
            (TimelinePoint(color: UIColor.red, filled: true), UIColor.red, "13:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "120 mins", ["Apple", "Apple", "Apple", "Apple", "Apple"], "Sun"),
            (TimelinePoint(color: UIColor.red, filled: true), UIColor.lightGray, "15:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "150 mins", ["Apple", "Apple"], "Sun"),
            (TimelinePoint(), UIColor.lightGray, "17:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", "60 mins", nil, "Sun"),
            (TimelinePoint(), UIColor.lightGray, "18:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", "60 mins", nil, "Moon"),
            (TimelinePoint(), UIColor.lightGray, "19:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", "30 mins", nil, "Moon"),
            (TimelinePoint(), backColor: UIColor.clear, "20:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", nil, nil, "Moon")
        ]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pagingViewController = PagingViewController<PagingIndexItem>()
        pagingViewController.dataSource = self
        pagingViewController.delegate = self
           
        // Setup for menu style
        pagingViewController.menuHorizontalAlignment = .left
        pagingViewController.textColor = UIColor.black
        pagingViewController.selectedTextColor = UIColor.black
        pagingViewController.indicatorColor = UIColor.orange
        
        pagingViewController.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        pagingViewController.selectedFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        pagingViewController.menuItemSize = .fixed(width: pagingViewController.menuItemSize.width, height: 44)
        //pagingViewController.menuItemSize = .sizeToFit(minWidth: pagingViewController.menuItemSize.width, height: 44)
        pagingViewController.menuItemSpacing = 15
        
        pagingViewController.menuInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        pagingViewController.indicatorOptions = .visible(
            height: 4,
            zIndex: Int.max,
            spacing: UIEdgeInsets.zero,
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        // Add the paging view controller as a child view controller and
        // contrain it to all edges.
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        // first default select menu News
        pagingViewController.select(index: 0)
//        setNavigationTitle(index: 0)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
     }

    

}


extension TransactionsViewController: PagingViewControllerDataSource {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        switch (index) {
        case 0:
            return PagingIndexItem(index: index, title: "Last month") as! T
        case 1:
            return PagingIndexItem(index: index, title: "This month") as! T
        case 2:
            return PagingIndexItem(index: index, title: "Future") as! T
        default:
            return PagingIndexItem(index: index, title: "") as! T
        }
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        
        NSLog(">>> pagingViewController > index: \(index)")
//        setNavigationTitle(index: index - 1)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        switch (index) {
//            case 0:
//                let newsViewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
//                newsViewController.HDNewsViewNavigationController = HDHomeNavigationController
//                newsViewController.HDNewsViewNavigationItem = HDHomeNavigationItem
//                return newsViewController
//            case 1:
//                let documentViewController = storyboard.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
//                return documentViewController
//            case 2:
//                let eventViewController = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
//                return eventViewController
//            case 3:
//                let contactViewController = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
//                return contactViewController
//            case 4:
//                let topicViewController = storyboard.instantiateViewController(withIdentifier: "TopicViewController") as! TopicViewController
//                return topicViewController
////            case 5:
////                let webViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
////
////                webViewController.requestType = .url
////                webViewController.urlString = Constants.URL_CARLENDAR
////
////                return webViewController
//            case 5:
//                let technologyViewController = storyboard.instantiateViewController(withIdentifier: "ActivityTableViewController") as! ActivityTableViewController
//                technologyViewController.topicType = .tech
//                technologyViewController.topicName = "Diễn đàn Công nghệ"
//                FooterView.shared?.isHidden = true
//                return technologyViewController
            
            
            default:
                return UIViewController()
        }
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
        return 3
    }
    
}

extension TransactionsViewController: PagingViewControllerDelegate {
    
    // We want the size of our paging items to equal the width of the
    // city title. Parchment does not support self-sizing cells at
    // the moment, so we have to handle the calculation ourself. We
    // can access the title string by casting the paging item to a
    // PagingTitleItem, which is the PagingItem type used by
    // FixedPagingViewController.
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, widthForPagingItem pagingItem: T, isSelected: Bool) -> CGFloat? {
        guard let item = pagingItem as? PagingIndexItem else { return 0 }
        
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: pagingViewController.menuItemSize.height)
        let attributes = [NSAttributedString.Key.font: pagingViewController.font]
        
        let rect = item.title.boundingRect(with: size,
                                           options: .usesLineFragmentOrigin,
                                           attributes: attributes,
                                           context: nil)
        
        let width = ceil(rect.width) + insets.left + insets.right
        
        /*if isSelected {
         return width * 1.5
         } else {
         return width * 1.0
         }*/
        
        return width
    }
}
