//
//  StackViewDelegate.swift
//  StackView
//
//  Created by Vandit Jain on 23/01/21.
//

import Foundation

public protocol StackViewDelegate {
    //Callback function when new card is opened
    func didOpenNewCard(for stackViewState: StackView.StackViewState)
    
    //Callback function when a card is closed and comeback to a card
    func didCombebackToCard(for stackViewState: StackView.StackViewState)
    
}
