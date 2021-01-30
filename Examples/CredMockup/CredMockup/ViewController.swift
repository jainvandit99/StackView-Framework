//
//  ViewController.swift
//  CredMockup
//
//  Created by Vandit Jain on 22/01/21.
//

import UIKit
import StackView


class ViewController: UIViewController{
    
    private let openStackViewButton = UIButton() //Button to open Stack Views
    private let closeStackViewButton = UIButton() //Button to close Stack Views
    private var cardViews = [StackCardView]() //Array of StackCardViews to be assigned
    
    private let firstCardPrimaryView = UIView()
    private let firstCardSecondaryView = UIView()
    private let secondCardBottomView = UIView()
    private let secondCardPrimaryView = UIView()
    private let thirdCardPrimaryView = UIView()
    private let thirdCardBottomView = UIView()
    private let stackView = StackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        stackView.delegate = self //Ensure that the stackview delegate is set for the callback functions
        
        cardViews.append(StackCardView(primaryView: firstCardPrimaryView)) //Initialised first cardView with PrimaryView
        cardViews.append(StackCardView(primaryView: secondCardPrimaryView)) //Initialised second cardView with PrimaryView
        cardViews.append(StackCardView(primaryView: thirdCardPrimaryView)) //Initialised third cardView with PrimaryView
        
        cardViews[0].setSecondaryView(secondaryView: firstCardSecondaryView) //Setting Secondary View of first Card
        cardViews[1].setBottomView(bottomView: secondCardBottomView) //Setting BottomView of second Card
        cardViews[2].setBottomView(bottomView: thirdCardBottomView) //Setting BottomView of third card
        
        stackView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height) //Setting StackView Frame to full screen
        stackView.cardViews = cardViews //Setting CardViews of stack [IMPORTANT!]
        view.addSubview(stackView) //Adding StackView to View
    }
    
    func setupViews(){
        openStackViewButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(openStackViewButton) //Adding Open Views Button
        
        //Setting Open Button Constraints
        openStackViewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        openStackViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openStackViewButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        openStackViewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        openStackViewButton.setTitle("Open", for: .normal)
        openStackViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        openStackViewButton.backgroundColor = UIColor(red: 251/255, green: 21/255, blue: 83/255, alpha: 1)
        openStackViewButton.layer.cornerRadius = 8
        openStackViewButton.addTarget(self, action: #selector(openButtonClicked), for: .touchUpInside)
        
        closeStackViewButton.translatesAutoresizingMaskIntoConstraints = false
        thirdCardPrimaryView.addSubview(closeStackViewButton) //Adding Close Views Button to third Card
        
        //Setting Close Button Constraints
        closeStackViewButton.topAnchor.constraint(equalTo: thirdCardPrimaryView.topAnchor, constant: 20).isActive = true
        closeStackViewButton.centerXAnchor.constraint(equalTo: thirdCardPrimaryView.centerXAnchor).isActive = true
        closeStackViewButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        closeStackViewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeStackViewButton.setTitle("Close all", for: .normal)
        closeStackViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        closeStackViewButton.backgroundColor = UIColor(red: 251/255, green: 21/255, blue: 83/255, alpha: 1)
        closeStackViewButton.layer.cornerRadius = 8
        closeStackViewButton.addTarget(self, action: #selector(closeStackViewButtonClicked), for: .touchUpInside)
        
        //There is no need to set frame of Primary View. Frame should be set of Secondary and Bottom Views
        firstCardPrimaryView.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1) //Setting Background Color of Card 1 Primary View
        
        //Setting Frame of First Card Secondary View
        firstCardSecondaryView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 120)
        
        
        //For Example the following code is to add Image View to the Card 1 secondary view
        let secondaryImageView = UIImageView()
        secondaryImageView.translatesAutoresizingMaskIntoConstraints = false
        firstCardSecondaryView.addSubview(secondaryImageView)
        secondaryImageView
            .contentMode = .scaleAspectFit
        secondaryImageView.widthAnchor.constraint(equalTo: firstCardSecondaryView.widthAnchor, constant: -16).isActive = true
        secondaryImageView.topAnchor.constraint(equalTo: firstCardSecondaryView.topAnchor, constant: 8).isActive = true
        secondaryImageView.centerXAnchor.constraint(equalTo: firstCardSecondaryView.centerXAnchor, constant: 0).isActive = true
        secondaryImageView.heightAnchor.constraint(equalTo: firstCardSecondaryView.heightAnchor, constant: -16).isActive = true
        
        
        ///Uncomment the following line to see the image in the secondary view
        //secondaryImageView.image = UIImage(named: "secondaryImg1")

        secondCardPrimaryView.backgroundColor = UIColor(red: 251/255, green: 21/255, blue: 83/255, alpha: 1) //Setting Background Color of Card 2 Primary View
        
        //Setting Frame of Second Card Secondary View
        secondCardBottomView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        
        ///Note: The Second Card doesn't have a secondary view and will default to blank view
        
        //Adding Label to the Card 2 bottom View
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        secondCardBottomView.addSubview(label)
        label.text = "Bottom View 2"
        label.textColor = UIColor.white
        label.leftAnchor.constraint(equalTo: secondCardBottomView.leftAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: secondCardBottomView.topAnchor, constant: 8).isActive = true
        
        thirdCardPrimaryView.backgroundColor = UIColor.green //Setting Background Color of Card 3 Primary View
        
        //Setting Frame of Third Card Secondary View
        thirdCardBottomView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        //Adding Label to the Card 3 bottom View
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        thirdCardBottomView.addSubview(label1)
        label1.text = "Bottom View 3"
        label1.textColor = UIColor.white
        label1.leftAnchor.constraint(equalTo: thirdCardBottomView.leftAnchor, constant: 16).isActive = true
        label1.topAnchor.constraint(equalTo: thirdCardBottomView.topAnchor, constant: 8).isActive = true
        
        
        ///Uncomment the following line to set custom corner radius
      //stackView.setCardCornerRadius(radius: 2)

    }
    
    //Target for open button
    @objc func openButtonClicked(){
        stackView.openNextCard() //Open Next Card of Stack View
    }
    
    //Target for close button
    @objc func closeStackViewButtonClicked(){
        stackView.closeAllCards() // Close All Cards of Stack View
    }
    
}

///Implementing Callback functions of Stack View
extension ViewController: StackViewDelegate {
    
    ///This function is callback for when a new Card is opened
    func didOpenNewCard(for stackViewState: StackView.StackViewState) {
        print("I'm here")

        switch stackViewState {
        case .first:
            print("first")
            break
        case .second:
            print("second")
            break
        case .third:
            print("third")
            break
        default:
            print("hello!")
        }
    }
    
    ///This function is callback for when a card is dismissed
    func didCombebackToCard(for stackViewState: StackView.StackViewState) {
        print("I'm here")

        switch stackViewState {
        case .first:
            print("first back")
            break
        case .second:
            print("second back")
            break
        case .third:
            print("third back")
            break
        default:
            print("hello! back")
        }
    }
}
