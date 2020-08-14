//
//  ViewController.swift
//  AutoUnfoldUIbutton
//
//  Created by Woody Liu on 2020/8/12.
//  Copyright © 2020 thisWhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainBackView: UIView!  //h:117 ,w:35 灰色長方形。
    
    @IBOutlet weak var firstButton: UIButton! //長寬35 的button
    @IBOutlet weak var firstBackView:UIView! //firstButton 背景視圖
    
    @IBOutlet weak var secondButton: UIButton! //以下同上
    @IBOutlet weak var secondBackView: UIView!
    
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var thirdBackView: UIView!
    
    var isUnfold: Bool = false //記錄Button 是展開還是關閉
    
    
    
    var reuseable: UIView = UnfoldButton(orgin: CGPoint(x: 300, y: 300))
    
    var point: CGPoint!
    
    @IBAction func testAnitmation(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstButton.addTarget(self, action: #selector(firstAction), for: .touchUpInside)
        self.view.addSubview(reuseable)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.secondBackView.center = firstBackView.center
        self.thirdBackView.center = firstBackView.center
        
        self.secondBackView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.thirdBackView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
}


extension ViewController {
    
    
    
    
    func openAnimator(){
        UIView.animate(withDuration: 0.5, animations: {
            self.firstButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 5 / 4)
            self.firstBackView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            
            self.secondBackView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.secondBackView.frame.origin = CGPoint(x: 0, y: 41)
            
            self.thirdBackView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.thirdBackView.frame.origin = CGPoint(x: 0, y: 0)
        })
        self.isUnfold = true
    }
    
    func closeAnimator(){
        UIView.animate(withDuration: 0.2, animations: {
            self.firstButton.transform = CGAffineTransform(rotationAngle: 0)
            self.firstBackView.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            self.secondBackView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.secondBackView.center = self.firstBackView.center
            
            self.thirdBackView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.thirdBackView.center = self.firstBackView.center
        })
        self.isUnfold = false
    }
    
    @objc func firstAction(){
        if isUnfold {
            closeAnimator() }
        else {
            openAnimator() }
    }
    
}

