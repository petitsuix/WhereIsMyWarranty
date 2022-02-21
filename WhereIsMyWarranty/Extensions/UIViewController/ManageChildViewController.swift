//
//  ManageChildViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 21/02/2022.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
            addChild(child)
            child.view.frame = view.bounds
            view.addSubview(child.view)
            child.didMove(toParent: self)
        }
    
    func remove() {
            guard parent != nil else { return }
            willMove(toParent: nil)
            removeFromParent()
            view.removeFromSuperview()
        }
}
