//
//  ViewController.swift
//  14Animation
//
//  Created by franze on 2017/3/28.
//  Copyright © 2017年 franze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var btn:CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn = CustomButton(frame: CGRect(x: 70, y: 300, width: 200, height: 40))
        btn.initialize(strokeColor: .black, fillColor: .white)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    func click(){
        if !btn.isSelected{
            btn.startAnimation()
        }else{
            btn.stopAnimation()
        }
        btn.isSelected = !btn.isSelected
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

