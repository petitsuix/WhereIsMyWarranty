//
//  FullScreenInvoicePhotoViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 03/02/2022.
//

import UIKit

class FullScreenInvoicePhotoViewController: UIViewController {
    
    // MARK: - Properties
    
    var invoicePhoto: Data?
    
    private let imageView = UIImageView()
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - UI configuration
    
    private func setup() {
        view.backgroundColor = MWColor.white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        if let invoicePhoto = invoicePhoto {
        imageView.image = UIImage(data: invoicePhoto)
        }
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),
            imageView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}
