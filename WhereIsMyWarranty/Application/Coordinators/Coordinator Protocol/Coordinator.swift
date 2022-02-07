//
//  Coordinator.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 06/12/2021.
//

import UIKit

protocol Coordinator {

    func start()
    //FIXME: Pourquoi on a besoin d'un protocol ? Et de mettre un navigationController systématique
    var navigationController: UINavigationController { get set }
}
