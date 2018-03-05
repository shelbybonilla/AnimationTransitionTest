//
//  ViewController.swift
//  AnimatorDismiss
//
//  Created by 朱　冰一 on 2018/03/01.
//  Copyright © 2018年 zhu.bingyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var presentButton: UIButton!
    
    var testPropertyAnimator: UIViewPropertyAnimator!
    
    var transAnimator = CustomAnimator()
    var interactiveAnimator: InteractiveAnimator?
    
    var rectangel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        rectangel = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        rectangel.backgroundColor = UIColor.blue
//        //
//        view.addSubview(rectangel)
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(rectTapped))
//        rectangel.addGestureRecognizer(tap)
//        
//        testPropertyAnimator = UIViewPropertyAnimator(duration: 5, curve: .easeInOut, animations: {
//            self.rectangel.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
//        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func presentAction(_ sender: Any) {
        let vc = BViewController()
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func rectTapped() {
        testPropertyAnimator.isReversed = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIViewControllerInteractiveTransitioning {
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        interactiveAnimator = InteractiveAnimator(attachTo: presented)
        let animator = CustomAnimator()
        animator.presenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = CustomAnimator()
        animator.presenting = false
        return animator
    }
    
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        guard let ia = interactiveAnimator else { return nil }
//        return ia.transitionInProgress ? ia : nil
//    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ia = interactiveAnimator else { return nil }
        return ia.transitionInProgress ? ia : nil
    }
}

