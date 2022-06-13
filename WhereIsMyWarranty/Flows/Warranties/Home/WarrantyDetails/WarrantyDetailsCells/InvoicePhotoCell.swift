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
}

extension InvoicePhotoCell {
    
    func setupUI() {
        invoiceImageView.translatesAutoresizingMaskIntoConstraints = false
        invoiceImageView.contentMode = .scaleAspectFit
        invoiceImageView.isUserInteractionEnabled = true
       // invoiceImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFullScreenImage)))
        
        selectionStyle = .none
        backgroundColor = MWColor.background
        contentView.addSubview(invoiceImageView)
        
        NSLayoutConstraint.activate([
//            invoiceImageView.heightAnchor.constraint(equalToConstant: 110),
//            invoiceImageView.widthAnchor.constraint(equalToConstant: 150),
            invoiceImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            invoiceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            invoiceImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            invoiceImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            invoiceImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        ])
    }
}
