//
//  CommonLoadingIndicator.swift
//
//  Created by Ragul kts on 17/01/20.
//  Copyright © 2020 Sudar. All rights reserved.
//

import UIKit
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
var vSpinner : UIView?
extension UIViewController {
    func showSpinner(onView : UIView? = nil) {
        var spinnerView = UIView()
        var fromView = UIView()
        if onView != nil{
            fromView = onView!
        } else {
            if let topController = UIApplication.topViewController() {
                print(topController)
                fromView = topController.view
            } else {
                print("From view for spinner is not set")
            }
        }
        spinnerView = UIView(frame: fromView.bounds)
        spinnerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            fromView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
}


// Usage :-
/*
 self.showSpinner(onView: self.view) -- to show (Recommended).
 self.showSpinner() -- to show if you're not sure about the view from which the loading should be shown.

 self.removeSpinner() -- to hide
 
 */
