//
//  UIViewController+Extension.swift
//  Example
//
//  Created by Loïc GRIFFIE on 05/06/2019.
//  Copyright © 2019 Move Upwards. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    /// Return the safeAreaFrame for iOS 9.0+
    internal var areaFrame: CGRect {
        var areaFrame: CGRect
        if #available(iOS 11.0, *) {
            areaFrame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            areaFrame = view.frame
            if !prefersStatusBarHidden {
                areaFrame.origin.y += 20.0
                areaFrame.size.height -= 20.0
            }
            if let navBarHeight = navigationController?.navigationBar.bounds.height {
                areaFrame.origin.y += navBarHeight
                areaFrame.size.height -= navBarHeight
            }
        }
        return areaFrame
    }
}
