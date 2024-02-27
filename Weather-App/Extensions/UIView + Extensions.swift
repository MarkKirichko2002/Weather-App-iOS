//
//  UIView + Extensions.swift
//  Weather-App
//
//  Created by Марк Киричко on 26.02.2024.
//

import UIKit

extension UIView {
    func addSubviews(views: UIView...) {
        views.forEach { addSubview($0)}
    }
}
