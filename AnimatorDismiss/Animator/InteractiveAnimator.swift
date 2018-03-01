//
//  InteractiveAnimator.swift
//  AnimatorDismiss
//
//  Created by 朱　冰一 on 2018/03/01.
//  Copyright © 2018年 zhu.bingyi. All rights reserved.
//

import UIKit

class InteractiveAnimator: UIPercentDrivenInteractiveTransition {
    
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
        self.prepareGestureRecognizer(in: viewController.view)
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            gesture.setTranslation(.zero, in: gesture.view)
        case .changed:
            let translation = gesture.translation(in: gesture.view)
            let percentage = translation.y / 200
            update(percentage)
        default:
            break
        }
    }
}
