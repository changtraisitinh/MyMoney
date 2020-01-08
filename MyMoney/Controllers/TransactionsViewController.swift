//
//  TransactionsViewController.swift
//  MyMoney
//
//  Created by Admin on 08/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import UIKit
import Parchment

class TransactionsViewController: UIViewController {

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
