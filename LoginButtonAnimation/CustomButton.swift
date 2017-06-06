//
//  CustomButton.swift
//  14Animation
//
//  Created by franze on 2017/6/5.
//  Copyright © 2017年 franze. All rights reserved.
//

import UIKit
let RAD = CGFloat.pi/180

class CustomButton: UIButton {
    private var topBorder:CAShapeLayer!//上边框
    private var bottomBorder:CAShapeLayer!//下边框
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initialize(strokeColor:UIColor,fillColor:UIColor){
        setTitle("Login", for: .normal)
        setTitle("", for: .selected)
        setTitleColor(.black, for: .normal)
        
        topBorder = CAShapeLayer()
        topBorder.frame = bounds
        topBorder.actions = ["position":NSNull(),"path":NSNull(),"bounds":NSNull()]//去掉隐式动画
        topBorder.path = getBorderPath(at: "top")
        topBorder.strokeColor = strokeColor.cgColor//边框颜色
        topBorder.fillColor = fillColor.cgColor//填充颜色
        layer.addSublayer(topBorder)
        
        bottomBorder = CAShapeLayer()
        bottomBorder.frame = bounds
        bottomBorder.actions = ["position":NSNull(),"path":NSNull(),"bounds":NSNull()]//去掉隐式动画
        bottomBorder.path = getBorderPath(at: "bottom")
        bottomBorder.strokeColor = strokeColor.cgColor//边框颜色
        bottomBorder.fillColor = fillColor.cgColor//填充颜色
        layer.addSublayer(bottomBorder)
    }
    
    func startAnimation(){
        let pathAnim = CABasicAnimation(keyPath: "path")
        pathAnim.duration = 0.25
        pathAnim.isRemovedOnCompletion = true
        bottomBorder.path = getCurvePath(at: "bottom")
        topBorder.path = getCurvePath(at: "top")
        bottomBorder.add(pathAnim, forKey: nil)
        topBorder.add(pathAnim, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2, execute: {
            let rotaionAnim  = CABasicAnimation(keyPath: "transform.rotation")
            rotaionAnim.duration = 1
            rotaionAnim.fillMode = kCAFillModeForwards
            rotaionAnim.repeatCount = MAXFLOAT
            rotaionAnim.toValue = -360*RAD
            self.bottomBorder.add(rotaionAnim, forKey: "rotaionAnim")
            self.topBorder.add(rotaionAnim, forKey: "rotaionAnim")
        })
    }
    
    func stopAnimation(){
        bottomBorder.removeAnimation(forKey: "rotaionAnim")
        topBorder.removeAnimation(forKey: "rotaionAnim")
        
        let pathAnim = CABasicAnimation(keyPath: "path")
        pathAnim.duration = 0.25
        pathAnim.isRemovedOnCompletion = true
        bottomBorder.path = getBorderPath(at: "bottom")
        topBorder.path = getBorderPath(at: "top")
        bottomBorder.add(pathAnim, forKey: nil)
        topBorder.add(pathAnim, forKey: nil)
    }
    
    //获取上下边框路径
    private func getBorderPath(at str:String)->CGPath{
        let borderPath = UIBezierPath()
        switch str {
        case "top":
            borderPath.move(to: CGPoint(x: bounds.width, y: bounds.height))
            borderPath.addLine(to: CGPoint(x: bounds.width, y: 0))
            borderPath.addLine(to: .zero)
        case "bottom":
            borderPath.move(to: .zero)
            borderPath.addLine(to: CGPoint(x: 0, y: bounds.height))
            borderPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        default:()
        }
        return borderPath.cgPath
    }

    //获取圆的路径
    private func getCurvePath(at str:String)->CGPath{
        var curve:UIBezierPath!
        let arrow = UIBezierPath()
        let arcCenter = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius:CGFloat = 20
        let l:CGFloat = 7//箭头长度
        switch str {
        case "top":
            curve = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: -30*RAD, endAngle: -180*RAD, clockwise: false)
            curve.addLine(to: CGPoint(x: arcCenter.x-radius-l/2, y: arcCenter.y-l*0.886))
            arrow.move(to: CGPoint(x: arcCenter.x-radius, y: arcCenter.y))
            arrow.addLine(to: CGPoint(x: arcCenter.x-radius+l/2, y: arcCenter.y-0.866*l))
        case "bottom":
            curve = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 150*RAD, endAngle: 0, clockwise: false)
            curve.addLine(to: CGPoint(x: arcCenter.x+radius-l/2, y:arcCenter.y+l*0.866))
            arrow.move(to: CGPoint(x: arcCenter.x+radius, y: arcCenter.y))
            arrow.addLine(to: CGPoint(x: arcCenter.x+radius+l/2, y: arcCenter.y+0.866*l))
        default:()
        }
        curve.append(arrow)
        return curve.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
