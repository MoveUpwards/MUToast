//
//  ViewController.swift
//  Example
//
//  Created by Move Upwards on 4 juin 2019.
//  Copyright © 2019 Move Upwards. All rights reserved.
//

import UIKit
import MUToast

// MARK: - ViewController

/// The ViewController
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toast = MUToast()
        toast.backgroundColor = .orange
        toast.cornerRadius = 20.0
        toast.icon = UIImage(named: "logo_star")
        toast.iconLeftPadding = 4.0
        toast.headerVerticalPadding = 20.0
        toast.title = "This is a Toast"
        toast.titleColor = .green
        toast.detail = "Read this before it disappear"
        toast.detailColor = .green
        toast.headerHorizontalPadding = 4.0
        
        toast.show(in: self)
    }
}
