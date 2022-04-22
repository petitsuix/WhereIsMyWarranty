//
//  deletionAlert.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 25/03/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    @objc func deletionAlert() {
        let alertVC = UIAlertController(title: "Voulez-vous fermer cette page ?", message: "Les modifications apportées ne seront pas enregistrées", preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Oui", style: .destructive, handler: { _ in
            self.dismiss(animated: true)
        }))
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
