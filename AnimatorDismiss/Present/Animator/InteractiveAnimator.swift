//
//  InteractiveAnimator.swift
//  AnimatorDismiss
//
//  Created by 朱　冰一 on 2018/03/01.
//  Copyright © 2018年 zhu.bingyi. All rights reserved.
//

import UIKit

class InteractiveAnimator: UIPercentDrivenInteractiveTransition {
    
    weak var viewController: UIViewController?
    var transitionInProgress = false
    var shouldCompleteTransition = false

    init(attachTo viewController: UIViewController) {
        self.viewController = viewController
        super.init()
        setupPangesture(view: viewController.view)
    }
    
    private func setupPangesture(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePangesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handlePangesture(_ gesture: UIPanGestureRecognizer) {
        guard let vc = viewController else { return }
        let viewTransition = gesture.translation(in: vc.view)
        let progress = viewTransition.y / vc.view.bounds.height
    
        switch gesture.state {
        case .began:
            transitionInProgress = true
            vc.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.3
            update(progress)
        case .cancelled:
            transitionInProgress = false
            cancel()
        case .ended:
            transitionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
        default:
           break
        }
    }
    
}
