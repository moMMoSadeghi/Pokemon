////
////  ActivityIndicator.swift
////  Pokemon
////
////  Created by iMommo on 12/11/22.
////
//
//import UIKit
//
//struct ActivityIndicator {
//
//    static let shared = ActivityIndicator()
//    
//    func showIndicatorLoading() {
//        let activityIndicatorView : UIActivityIndicatorView {
//            let activity = UIActivityIndicatorView()
//            activity.translatesAutoresizingMaskIntoConstraints = false
//            activity.hidesWhenStopped = true
//            activity.color = UIColor(named: "green")
//            let horizentalConstraint = NSLayoutConstraint(item: activity, attribute: NSLayoutAttribute.centerX  relatedBy: NSLayoutRelation.equal, toItem: , attribute: <#T##NSLayoutConstraint.Attribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
//        }()
//        view.addSubview(activityIndicator)
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.color = UIColor.black
//        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
//        view.addConstraint(horizontalConstraint)
//        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
//        view.addConstraint(verticalConstraint)
//    }
//
//}
