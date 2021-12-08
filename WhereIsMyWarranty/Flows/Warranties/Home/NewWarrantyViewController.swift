//
//  NewWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 07/12/2021.
//

import UIKit

class NewWarrantyOneViewController: UIViewController {
    
    let navBarAppearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 27)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor.black]
        
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.9285728335, green: 0.7623301148, blue: 0.6474828124, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
