//
//  CViewController.swift
//  AnimatorDismiss
//
//  Created by 朱　冰一 on 2018/03/02.
//  Copyright © 2018年 zhu.bingyi. All rights reserved.
//

import UIKit

class CViewController: UIViewController {
    
    var interactor: NaviInteractor?

    @IBOutlet weak var pushButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = NaviInteractor(attachTo: self)
        // Do any additional setup after loading the view.
    }

    @IBAction func pushViewController(_ sender: UIButton) {
        let vc = DViewController()
        navigationController?.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            interactor = NaviInteractor(attachTo: toVC)
            return NaviAnimator(duration: 0.3, isPresenting: true, originFrame: view.frame)
        case .pop, .none:
            return NaviAnimator(duration: 0.3, isPresenting: false, originFrame: view.frame)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ia = interactor else { return  nil }
        return ia.transitionInProgress ? ia : nil
    }
}


class NaviInteractor: UIPercentDrivenInteractiveTransition {
    weak var navigationController: UINavigationController?
    var transitionInProgress = false
    var shouleCompleteTransition = false
    
    init?(attachTo viewController: UIViewController) {
        if let nav = viewController.navigationController {
            self.navigationController = nav
            super.init()
            setupBakcGesture(view: viewController.view)
        } else {
            return nil
        }
    }
    
    private func setupBakcGesture(view: UIView) {
        let switpeBackGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleBackGesture(_:)))
        switpeBackGesture.edges = .left
        view.addGestureRecognizer(switpeBackGesture)
    }
    
    @objc private func handleBackGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        guard let navi = self.navigationController else { return }
        let viewTransition = gesture.translation(in: gesture.view?.superview)
        let progress = viewTransition.x / navi.view.frame.width
        
        switch gesture.state {
        case .began:
            transitionInProgress = true
            navi.popViewController(animated: true)
        case .changed:
            shouleCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            transitionInProgress = false
            cancel()
        case .ended:
            transitionInProgress = false
            shouleCompleteTransition ? finish() : cancel()
        default:
            break
        }
    }
}
