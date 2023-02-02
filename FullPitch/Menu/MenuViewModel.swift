//
//  MenuViewModel.swift
//  FullPitch
//
//  Created by Hira on 2021/10/1.
//

import UIKit

class MenuViewModel: NSObject {
    
    /// 動畫效果
    func iconImgAnimate(_ width: CGFloat) -> CAAnimationGroup {
        //這一段是透明度
        let animationO = CABasicAnimation(keyPath: "opacity")
        animationO.byValue = 1
        animationO.duration = 0.4
        animationO.repeatCount = 0
        animationO.isRemovedOnCompletion = false
        animationO.fillMode = CAMediaTimingFillMode.forwards
        
        //這一段是向右移
        let mAnimationX = CABasicAnimation(keyPath: "transform.translation.x")
        mAnimationX.duration = 1
        mAnimationX.byValue = width * 0.6
        mAnimationX.repeatCount = 1
        mAnimationX.fillMode = .forwards
        
        //這一段是旋轉
        let animationZ = CABasicAnimation(keyPath: "transform.rotation.z")
        animationZ.byValue = 2 * Double.pi + 2.3
        animationZ.duration = 1
        animationZ.repeatCount = 1
        animationZ.isRemovedOnCompletion = false
        animationZ.fillMode = CAMediaTimingFillMode.forwards

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animationO, mAnimationX, animationZ]
        groupAnimation.duration = 1
        groupAnimation.repeatCount = 0
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = CAMediaTimingFillMode.forwards
        return groupAnimation
    }
}
