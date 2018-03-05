//
//  NaviAnimator.swift
//  AnimatorDismiss
//
//  Created by 朱　冰一 on 2018/03/05.
//  Copyright © 2018年 zhu.bingyi. All rights reserved.
//

import Foundation
import UIKit

class NaviAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval
    var isPresenting: Bool
    var originFrame: CGRect
    
    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        //fromView always appear in the container, the difference is the z axis
        //while presenting you need to add toView on the top
        //while dismissing you need to insert the toView below the fromView
        isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        //set the init frame for toView
        toView.frame = isPresenting ? container.frame.offsetBy(dx: container.bounds.width, dy: 0) : container.frame
        
        
        
        UIView.animate(withDuration: duration, animations: {
            if self.isPresenting {
                toView.frame = toView.frame.offsetBy(dx: -container.frame.width, dy: 0)
            } else {
                fromView.frame = fromView.frame.offsetBy(dx: container.frame.width, dy: 0)
            }
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
       return duration
    }
}
