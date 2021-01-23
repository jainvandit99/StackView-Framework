//
//  Extension-UIView.swift
//  StackView
//
//  Created by Vandit Jain on 23/01/21.
//

import UIKit

extension UIView {
    func setViewCornerRadius(radius: CGFloat){
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = rectShape
    }
}
