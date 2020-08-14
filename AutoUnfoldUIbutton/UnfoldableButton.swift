//
//  UnfoldableButton.swift
//  AutoUnfoldUIbutton
//
//  Created by Woody Liu on 2020/8/13.
//  Copyright © 2020 thisWhat. All rights reserved.
//

import Foundation
import UIKit



class UnfoldButton: UIView {
    var defaultFrame: CGRect = CGRect(x: 100, y: 100, width: 35, height: 117)
    var isUnfold: Bool = false
    var color = UIColor.clear
    
    @ReuseUnfoldBackView(orgin: CGPoint(x: 0, y: 82), color: UIColor.white) var firstBackView: UIView
    @ReuseUIbutton(image: UIImage(systemName: "plus.circle")!, orgin: CGPoint(x: 0, y: 0)) var firstButton: UIButton
    
    @ReuseUnfoldBackView(orgin: CGPoint(x: 0, y: 82), color: UIColor.clear) var secondView: UIView
    @ReuseUIbutton(image: UIImage(systemName: "person.fill")!, orgin: CGPoint(x: 0, y: 0)) var secondButton : UIButton
    
    @ReuseUnfoldBackView(orgin: CGPoint(x: 0, y: 82), color: UIColor.clear) var thirdView: UIView
    @ReuseUIbutton(image: UIImage(systemName: "plus.app")!, orgin: CGPoint(x: 0, y: 0)) var thirdButton : UIButton
    
    
    init(orgin: CGPoint){
        super.init(frame:defaultFrame)
        self.frame.origin = orgin

        setupButton()
        configureButton()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.addSubview(thirdView)
        self.thirdView.addSubview(thirdButton)
        
        self.addSubview(secondView)
        secondView.addSubview(secondButton)
        self.addSubview(firstBackView)
        self.firstBackView.addSubview(self.firstButton)
       
        firstButton.addTarget(self, action: #selector(unfoldController), for: .touchUpInside)
    }
    
    private func configureButton(){
        self.backgroundColor = .clear
        self.firstButton.tintColor = .gray
        self.secondButton.tintColor = .gray
        self.thirdButton.tintColor = .gray
        self.thirdButton.backgroundColor = .clear
        secondView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        thirdView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
    }
    
}




extension UnfoldButton {
    @objc func unfoldController(){
        if isUnfold {
            closeView()
        }else {
            openView()
        }
    }
    
    
    private func openView(){
        UIView.animate(withDuration: 0.5, animations: {
            self.firstButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 5 / 4)
            self.firstBackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            self.secondView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.secondView.frame.origin = CGPoint(x: 0, y: 41)
            
            self.thirdView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.thirdView.frame.origin = CGPoint(x: 0, y: 0)
        })
        self.isUnfold = true
    }
    
    private func closeView(){
        UIView.animate(withDuration: 0.2, animations: {
            self.firstButton.transform = CGAffineTransform(rotationAngle: 0)
            self.firstBackView.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            self.secondView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.secondView.center = self.firstBackView.center
            
            self.thirdView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.thirdView.center = self.firstBackView.center
        })
        self.isUnfold = false
    }
}


@propertyWrapper
class ReuseUnfoldBackView {
    public var wrappedValue: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    
    public init(orgin: CGPoint, color: UIColor) {
        self.wrappedValue.frame.origin = orgin
        self.wrappedValue.backgroundColor = color
        self.configureView()
    }
    
    
    private func configureView(){
        self.wrappedValue.layer.cornerRadius = 35 / 2
        self.wrappedValue.layer.shadowColor = UIColor.darkGray.cgColor
        self.wrappedValue.layer.shadowOffset = CGSize(width: 2, height: 0.5)
        self.wrappedValue.layer.shadowOpacity = 0.6
    }
    
}


@propertyWrapper
class ReuseUIbutton {
    public var wrappedValue: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    
    public init(image: UIImage,orgin: CGPoint) {
        self.wrappedValue.frame.origin = orgin
        self.wrappedValue.setBackgroundImage(image, for: .normal)
    }
    
    
    private func configureButton(){
        self.wrappedValue.layer.cornerRadius = 35 / 2
        self.wrappedValue.backgroundColor = .white
    }
    
}
