//
//  TopPresentationCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 09/06/2022.
//

import UIKit

class TopPresentationCell: UITableViewCell {
    
    // MARK: - Internal properties
    
    static let identifier = "TopPresentationCell"
    
    var warranty: Warranty? {
        didSet {
            refreshData()
        }
    }
    
    // MARK: - Private properties
    
    private let productImageView = UIImageView()
    private let productName = UILabel()
    private let warrantyStatusLabel = UILabel()
    private let warrantyStatusView = UIView()
    private let innerRightStackView = UIStackView()
    private let bottomBorder = UIView()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    // MARK: - Methods
    
    private func getRemainingDaysFromEndDate() -> String {
           let calendar = NSCalendar.current
   
        guard let warrantyEnd = warranty?.warrantyEnd else { return "0" }
           let date1 = calendar.startOfDay(for: Date())
           let date2 = calendar.startOfDay(for: warrantyEnd)
   
           let components = calendar.dateComponents([.day], from: date1, to: date2)
           guard let remainingDays = components.day else { return "0" }
           return String("\(remainingDays)")
       }
    
    private func refreshData() {
        setupData()
    }
}

// MARK: - Configuration

extension TopPresentationCell {
    func setupUI() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.isAccessibilityElement = false
        productImageView.roundingViewCorners(radius: 74)
        productImageView.layer.borderWidth = 1.5
        productImageView.layer.borderColor = MWColor.background.cgColor
        
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.font = MWFont.warrantyDetailsProductName
        productName.accessibilityLabel = Strings.warrantyName
        productName.numberOfLines = 2
        productName.textAlignment = .center
 
        warrantyStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        warrantyStatusLabel.textAlignment = .center
        warrantyStatusLabel.textColor = MWColor.white
        warrantyStatusLabel.font = MWFont.warrantyStatusLabel
        warrantyStatusLabel.numberOfLines = 2
        
        warrantyStatusView.roundingViewCorners(radius: 8)
        warrantyStatusView.contentMode = .center
        warrantyStatusView.addSubview(warrantyStatusLabel)
        
        innerRightStackView.translatesAutoresizingMaskIntoConstraints = false
        innerRightStackView.contentMode = .top
        innerRightStackView.axis = .vertical
        innerRightStackView.alignment = .center
        innerRightStackView.distribution = .equalSpacing
        //innerRightStackView.spacing = 8
        innerRightStackView.addArrangedSubview(productName)
        innerRightStackView.addArrangedSubview(warrantyStatusView)
        
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = MWColor.bluegreyElement
    
        isUserInteractionEnabled = false
        backgroundColor = MWColor.background
        contentView.addSubview(productImageView)
        contentView.addSubview(innerRightStackView)
        contentView.addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: 150),
            productImageView.widthAnchor.constraint(equalToConstant: 150),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: innerRightStackView.leadingAnchor, constant: -16),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            //productImageView.bottomAnchor.constraint(equalTo: bottomBorder.topAnchor, constant: -24),
            
            innerRightStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            innerRightStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            innerRightStackView.bottomAnchor.constraint(equalTo: bottomBorder.topAnchor, constant: -40),
            
            warrantyStatusLabel.leadingAnchor.constraint(equalTo: warrantyStatusView.leadingAnchor, constant: 8),
            warrantyStatusLabel.trailingAnchor.constraint(equalTo: warrantyStatusView.trailingAnchor, constant: -8),
            warrantyStatusLabel.topAnchor.constraint(equalTo: warrantyStatusView.topAnchor, constant: 4),
            warrantyStatusLabel.bottomAnchor.constraint(equalTo: warrantyStatusView.bottomAnchor, constant: -4),
            
            bottomBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupData() {
        if let image = warranty?.productPhoto {
            productImageView.image = UIImage(data: image)
        }
        productName.text = warranty?.name
        productName.accessibilityValue = productName.text
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .long
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if warranty?.lifetimeWarranty == false {
            if Int(getRemainingDaysFromEndDate()) ?? 0 < 0 {
                warrantyStatusLabel.text = Strings.warrantyExpired
                warrantyStatusView.backgroundColor = MWColor.warrantyExpiredRed
            } else {
                if let text = warranty?.warrantyEnd {
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
