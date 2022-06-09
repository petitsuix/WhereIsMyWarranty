//
//  TopPresentationCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 09/06/2022.
//

import UIKit

class TopPresentationCell: UITableViewCell {
    
    static let identifier = "TopPresentationCell"
    var viewModel: WarrantyDetailsViewModel? {
        didSet {
            refreshData()
        }
    }
    
    // MARK: - Private properties

    private let parentStackView = UIStackView()
    private let innerRightStackView = UIStackView()
     let productImageView = UIImageView()
     let productName = UILabel()
    private let warrantyStatusView = UIView()
     let warrantyStatusLabel = UILabel()
    
    
    // MARK: - Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    private func getRemainingDaysFromEndDate() -> String {
           let calendar = NSCalendar.current
   
           guard let warrantyEnd = viewModel?.warranty.warrantyEnd else { return "0" }
           let date1 = calendar.startOfDay(for: Date())
           let date2 = calendar.startOfDay(for: warrantyEnd)
   
           let components = calendar.dateComponents([.day], from: date1, to: date2)
           guard let remainingDays = components.day else { return "0" }
           return String("\(remainingDays)")
       }
    
    func refreshData() {
        setupData()
    }
}

extension TopPresentationCell {
    func setupUI() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.isAccessibilityElement = false
        productImageView.roundingViewCorners(radius: 64)
        productImageView.layer.borderWidth = 1.5
        productImageView.layer.borderColor = MWColor.background.cgColor
        
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.font = MWFont.warrantyDetailsProductName
        productName.accessibilityLabel = Strings.warrantyName
        productName.numberOfLines = 2
        
        warrantyStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        warrantyStatusLabel.textAlignment = .center
        warrantyStatusLabel.textColor = MWColor.white
        warrantyStatusLabel.font = MWFont.warrantyStatusLabel
        warrantyStatusLabel.numberOfLines = 2
        
        warrantyStatusView.roundingViewCorners(radius: 8)
        warrantyStatusView.addSubview(warrantyStatusLabel)
        
        innerRightStackView.axis = .vertical
        innerRightStackView.alignment = .center
        innerRightStackView.distribution = .equalSpacing
        innerRightStackView.spacing = 16
        innerRightStackView.addArrangedSubview(productName)
        innerRightStackView.addArrangedSubview(warrantyStatusView)
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .horizontal
        parentStackView.alignment = .center
        parentStackView.addArrangedSubview(productImageView)
        parentStackView.addArrangedSubview(innerRightStackView)
        
        backgroundColor = MWColor.background
        addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: 130),
            productImageView.widthAnchor.constraint(equalToConstant: 130),
            
            warrantyStatusLabel.leadingAnchor.constraint(equalTo: warrantyStatusView.leadingAnchor, constant: 8),
            warrantyStatusLabel.trailingAnchor.constraint(equalTo: warrantyStatusView.trailingAnchor, constant: -8),
            warrantyStatusLabel.topAnchor.constraint(equalTo: warrantyStatusView.topAnchor, constant: 4),
            warrantyStatusLabel.bottomAnchor.constraint(equalTo: warrantyStatusView.bottomAnchor, constant: -4),
            
            parentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            parentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            parentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupData() {
        if let image = viewModel?.warranty.productPhoto {
            productImageView.image = UIImage(data: image)
        }
        productName.text = viewModel?.warranty.name
        productName.accessibilityValue = productName.text
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .long
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if viewModel?.warranty.lifetimeWarranty == false {
            if Int(getRemainingDaysFromEndDate()) ?? 0 < 0 {
                warrantyStatusLabel.text = Strings.warrantyExpired
                warrantyStatusView.backgroundColor = MWColor.warrantyExpiredRed
            } else {
                if let text = viewModel?.warranty.warrantyEnd {
                    warrantyStatusLabel.text = Strings.coveredUntil + "\n\(formatter1.string(from: text))"
                    warrantyStatusView.backgroundColor = MWColor.warrantyActiveGreen
                }
            }
        } else {
            warrantyStatusLabel.text = Strings.lifetimeWarrantyTextWithExtraLine
            warrantyStatusView.backgroundColor = MWColor.warrantyActiveGreen
        }
    }
}
