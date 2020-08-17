//
//  UIView.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/15.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
