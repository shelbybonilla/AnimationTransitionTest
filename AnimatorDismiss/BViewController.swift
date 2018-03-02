//
//  BViewController.swift
//  AnimatorDismiss
//
//  Created by 朱　冰一 on 2018/03/01.
//  Copyright © 2018年 zhu.bingyi. All rights reserved.
//

import UIKit

class BViewController: UIViewController {
    
    var interactor: InteractiveAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        prepareGestureRecognizer()
//        let tap = UITapGestureRecognizer()
//        tap.addTarget(self, action: #selector(dismissVC))
//        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func prepareGestureRecognizer() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            gesture.setTranslation(.zero, in: gesture.view)
            dismiss(animated: true, completion: nil)
        case .changed:
            let translation = gesture.translation(in: gesture.view)
            let percentage = translation.y / 200
            print("\(percentage)")
            if (percentage < 1) {
                interactor?.update(percentage)
            } else {
                interactor?.finish()
            }
        case .ended:
            let translation = gesture.translation(in: gesture.view)
            let percentage = translation.y / 200
            if (percentage < 1) {
                interactor?.cancel()
            } else {
                interactor?.finish()
            }
        default:
            break
        }
    }

}
