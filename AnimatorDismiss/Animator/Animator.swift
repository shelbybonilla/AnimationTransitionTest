//
//  Animator.swift
//  AnimatorDismiss
//
//  Created by 朱　冰一 on 2018/03/01.
//  Copyright © 2018年 zhu.bingyi. All rights reserved.
//

import Foundation
import UIKit

class CustomAnimator: NSObject{
    var presenting: Bool = false
    var interactionController: InteractiveAnimator?
}

extension CustomAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to)
        else { return }
        
        var toViewStartFrame = transitionContext.initialFrame(for: toVC)
        let toViewFinalFrame = transitionContext.finalFrame(for: toVC)
        
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromVC)
        
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
    
        
        if presenting {
            
            toViewStartFrame = CGRect(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: containerView.bounds.height)
            toView.frame = toViewStartFrame
            containerView.addSubview(toView)
        } else {
            fromViewFinalFrame = CGRect(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: containerView.bounds.height)
            toView.frame = containerView.frame
            containerView.addSubview(toView)
            containerView.bringSubview(toFront: fromView)
        }
        
        UIView.animate(withDuration: duration, animations: {
            if self.presenting {
                toView.frame = toViewFinalFrame
            } else {
                fromView.frame = fromViewFinalFrame
            }
        }) { (_) in
            //let success = !transitionContext.transitionWasCancelled
//            if (!self.isPresented && !success) || (self.isPresented && success){
//                toVC.view.removeFromSuperview()
//            }
            if self.presenting {
                fromView.removeFromSuperview()
            }
            self.presenting = !self.presenting
            transitionContext.completeTransition(true)
        }
    }
}


