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
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func dismissInvoicePhotoModal() {
        dismiss(animated: true)
    }
    
    @objc func openActivityViewController() {
        let items = [invoicePhoto]
        let activityController = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    // MARK: - UI configuration
    
    private func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissInvoicePhotoModal))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(openActivityViewController))
        view.backgroundColor = MWColor.systemBackground
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        if let invoicePhoto = invoicePhoto {
        imageView.image = UIImage(data: invoicePhoto)
        }
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: imageView.widthAnchor),

            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scrollView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),
            scrollView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            scrollView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}

extension FullScreenInvoicePhotoViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    }
}
