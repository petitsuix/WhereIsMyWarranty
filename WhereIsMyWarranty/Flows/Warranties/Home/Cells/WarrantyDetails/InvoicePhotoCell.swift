//
//  InvoicePhotoCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 09/06/2022.
//

import UIKit

class InvoicePhotoCell: UITableViewCell {
    
    static let identifier = "InvoicePhotoCell"
    
    var viewModel: WarrantyDetailsViewModel?
    
    // MARK: - Private properties
    
    let invoiceImageView = UIImageView()
    
    // MARK: - Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    @objc func showFullScreenImage() {
        viewModel?.showFullScreenInvoicePhoto()
    }
}

extension InvoicePhotoCell {
    
    func setupUI() {
        invoiceImageView.translatesAutoresizingMaskIntoConstraints = false
        invoiceImageView.contentMode = .scaleAspectFit
        invoiceImageView.isUserInteractionEnabled = true
        invoiceImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFullScreenImage)))
        
        backgroundColor = MWColor.background
        addSubview(invoiceImageView)
        
        NSLayoutConstraint.activate([
            invoiceImageView.heightAnchor.constraint(equalToConstant: 90),
            invoiceImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
