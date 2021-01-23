//
//  CustomStackCardView.swift
//  StackView
//
//  Created by Vandit Jain on 23/01/21.
//

import UIKit

public class StackCardView{
    var primaryView: UIView
    var secondaryView: UIView
    var bottomView: UIView
    
    public init(primaryView: UIView) {
        self.primaryView = primaryView
        secondaryView = UIView(frame: CGRect(x: 0, y: 0, width: primaryView.frame.width, height: 50))
        bottomView = UIView(frame: CGRect(x: 0, y: 0, width: primaryView.frame.width, height: 50))
    }
    public func setBottomView(bottomView: UIView){
        self.bottomView = bottomView
    }
    public func setSecondaryView(secondaryView: UIView){
        self.secondaryView = secondaryView
    }
}

