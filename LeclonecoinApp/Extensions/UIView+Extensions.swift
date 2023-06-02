//
//  UIView+Extensions.swift
//  LeclonecoinApp
//
//  Created by Эл on 03.06.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
