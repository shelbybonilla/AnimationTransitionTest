//
//  CViewController.swift
//  AnimatorDismiss
//
//  Created by 朱　冰一 on 2018/03/02.
//  Copyright © 2018年 zhu.bingyi. All rights reserved.
//

import UIKit

class CViewController: UIViewController {

    @IBOutlet weak var pushButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
            return NaviAnimator(duration: 1, isPresenting: true, originFrame: view.frame)
        case .pop, .none:
            return NaviAnimator(duration: 1, isPresenting: false, originFrame: view.frame)
        }
    }
    
}
