//
//  StackView.swift
//  StackView
//
//  Created by Vandit Jain on 23/01/21.
//

import UIKit

public class StackView: UIView {
    
    private var currentState: StackViewState = .none
    
    public var delegate: StackViewDelegate?
    
    public var cardViews:[StackCardView] {
        didSet{
            addSubviews()
        }
    }
    private var cornerRadius: CGFloat = 25 {
        didSet{
            updateViewsCornerRadius()
        }
    }
    
    public init(frame: CGRect, cardViews: [StackCardView]) {
        self.cardViews = cardViews
        super.init(frame: frame)
        self.isHidden = true
        self.addSubviews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), cardViews: [])
    }
    
    public func setCardCornerRadius(radius: CGFloat){
        self.cornerRadius = radius
    }
    
    private func updateViewsCornerRadius(){
        for view in cardViews{
            view.primaryView.setViewCornerRadius(radius: self.cornerRadius)
            view.secondaryView.setViewCornerRadius(radius: self.cornerRadius)
            view.bottomView.setViewCornerRadius(radius: self.cornerRadius)
            view.primaryView.layoutIfNeeded()
        }
    }
    
    private func addSubviews(){
        for view in cardViews{
            view.primaryView.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height)
            view.primaryView.setNeedsDisplay()
            addSubview(view.primaryView)
            view.primaryView.addSubview(view.secondaryView)
            view.primaryView.addSubview(view.bottomView)
            view.secondaryView.isHidden = true
            view.bottomView.isHidden = true
            view.primaryView.setViewCornerRadius(radius: self.cornerRadius)
            view.secondaryView.setViewCornerRadius(radius: self.cornerRadius)
            view.bottomView.setViewCornerRadius(radius: self.cornerRadius)
            view.secondaryView.backgroundColor = view.primaryView.backgroundColor
            view.bottomView.backgroundColor = view.primaryView.backgroundColor
        }
    }
    
    //Function opens the next card in stack
    @objc public func openNextCard(){
        
        //Check if at end of stack
        if currentState == .third{
            return
        }
        self.isHidden = false
        var offset: CGFloat = 100
        for i in 0..<currentState.rawValue {
            offset = offset + cardViews[i].secondaryView.frame.height
        }
        if currentState.rawValue != 0{
            offset = offset + cardViews[currentState.rawValue].bottomView.frame.height
        }
        UIView.animate(withDuration: 0.5, animations:  {
            self.cardViews[self.currentState.rawValue].primaryView.center.y = self.cardViews[self.currentState.rawValue].primaryView.center.y - self.frame.height + offset
            self.cardViews[self.currentState.rawValue].primaryView.layoutIfNeeded()
            self.cardViews[self.currentState.rawValue].bottomView.isHidden = true
        }, completion: { (bool) in
            UIView.animate(withDuration: 0.2) {
                if self.currentState.rawValue != 0 {
                    self.cardViews[self.currentState.rawValue-1].secondaryView.isHidden = false
                }
                if self.currentState.rawValue != self.cardViews.count-1 {
                    self.cardViews[self.currentState.rawValue + 1].primaryView.center.y = self.cardViews[self.currentState.rawValue + 1].primaryView.center.y - self.cardViews[self.currentState.rawValue + 1].bottomView.frame.height
                    self.cardViews[self.currentState.rawValue+1].primaryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openNextCard)))
                    self.cardViews[self.currentState.rawValue+1].bottomView.isHidden = false
                    self.cardViews[self.currentState.rawValue+1].primaryView.layoutIfNeeded()
                }
            }
            self.cardViews[self.currentState.rawValue].primaryView.gestureRecognizers?.removeAll()
            let swipeDownGestureRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(self.closeCurrentCard))
            swipeDownGestureRecogniser.direction = .down
            self.cardViews[self.currentState.rawValue].primaryView.addGestureRecognizer(swipeDownGestureRecogniser)
            self.currentState = StackViewState(rawValue: self.currentState.rawValue + 1) ?? StackViewState(rawValue: 0)!
            self.delegate?.didOpenNewCard(for: self.currentState)
        })
    }
    
    //Function closes the current card in the stack
    @objc public func closeCurrentCard(){
        
        //Check if at the beginning of the stack
        if currentState == .none{
            return
        }
        
        self.currentState = StackViewState(rawValue: self.currentState.rawValue - 1) ?? StackViewState(rawValue: 0)!
        var offset: CGFloat
        if currentState.rawValue == 0{
            offset = 0
        }else{
            offset = self.cardViews[currentState.rawValue].bottomView.frame.height
        }
        UIView.animate(withDuration: 0.5) {
            self.cardViews[self.currentState.rawValue].primaryView.center.y = 1.5*self.frame.height - offset
            self.cardViews[self.currentState.rawValue].primaryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openNextCard)))
            if self.currentState.rawValue != 0{
                self.cardViews[self.currentState.rawValue-1].secondaryView.isHidden = true
            }
            if self.currentState.rawValue != self.cardViews.count-1 {
                self.cardViews[self.currentState.rawValue + 1].primaryView.center.y = self.cardViews[self.currentState.rawValue + 1].primaryView.center.y + self.cardViews[self.currentState.rawValue + 1].bottomView.frame.height
            }
        } completion: { (Bool) in
            self.cardViews[self.currentState.rawValue].bottomView.isHidden = false
            if self.currentState.rawValue == 0{
                self.isHidden = true
            }
        }
        delegate?.didCombebackToCard(for: currentState)
    }
    
    public func closeAllCards(){
        for i in stride(from: cardViews.count-1, through: 0, by: -1) {
            let view = cardViews[i]
            UIView.animate(withDuration: 0.4, delay: 0.1*Double(cardViews.count - 1 - i), animations: {
                view.primaryView.center.y = 1.5*view.primaryView.frame.height
            }, completion: { (bool) in
                if i==0 {
                    self.isHidden = true
                }
            })
        }
        self.currentState = StackViewState(rawValue: 0)!
    }
}
