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
        let alertVC = UIAlertController(title: "Voulez-vous supprimer cette garantie ?", message: "Cette garantie ne sera pas sauvegardée", preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Supprimer", style: .destructive, handler: { _ in
            self.dismiss(animated: true)
        }))
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
