//
//  WarrantiesCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/12/2021.
//

import UIKit

class WarrantiesCell: UICollectionViewCell {
    
    // MARK: - Internal properties
    
    static let identifier = Strings.cellIdentifier
    
    var warranty: Warranty? {
        didSet {
            refreshWarrantyData()
        }
    }
    
    // MARK: - Private properties
    
    private var warrantyProductImageView = UIImageView()
    private var infoStackView = UIStackView()
    private var warrantyName = UILabel()
    private var warrantyEnd = UILabel()
    private var remainingTime = UILabel()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    // Overriding layoutSubviews if autoresizing and constraint-based behaviors of subviews do not offer the behavior we want.
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Private Methods
    
    private func refreshWarrantyData() {
        if let invoicePhoto = warranty?.productPhoto {
            warrantyProductImageView.image = UIImage(data: invoicePhoto)
        }
        
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        formatter1.locale = Locale(identifier: "fr_FR")
        warrantyName.text = warranty?.name
        
        if warranty?.lifetimeWarranty == false {
            warrantyEnd.isHidden = false
            
            if Int(getRemainingDaysFromEndDate()) ?? 0 < 0 {
                remainingTime.text = "0" + Strings.remainingDays
                warrantyEnd.text = Strings.warrantyExpiredCellStyle
            } else {
                remainingTime.text = getRemainingDaysFromEndDate() + Strings.remainingDays
                if let warrantyEndDate = warranty?.warrantyEnd {
                    warrantyEnd.text = Strings.coveredUntil + "\(formatter1.string(from: warrantyEndDate))"
                }
            }
        } else {
            warrantyEnd.isHidden = true
            remainingTime.text = Strings.lifetimeWarrantyDefaultText
        }
    }
    
    private func getRemainingDaysFromEndDate() -> String {
        let calendar = NSCalendar.current
        
        guard let warrantyEnd = warranty?.warrantyEnd else { return "0" }
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: warrantyEnd)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        guard let remainingDays = components.day else { return "0" }
        return String("\(remainingDays)")
    }
}

// MARK: - View configuration

extension WarrantiesCell {
    
    private func setup() {
        warrantyProductImageView.translatesAutoresizingMaskIntoConstraints = false
        warrantyProductImageView.roundingViewCorners(radius: 10)
        warrantyProductImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner] // to round specific corners (top left and bottom left)
        
        warrantyName.font = MWFont.cellWarrantyName
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
        infoStackView.spacing = 8
        
        infoStackView.addArrangedSubview(warrantyName)
        infoStackView.addArrangedSubview(remainingTime)
        infoStackView.addArrangedSubview(warrantyEnd)
        
        contentView.backgroundColor = MWColor.white
        contentView.layer.borderColor = MWColor.bluegrey.cgColor
        contentView.layer.borderWidth = 1.7
        roundingCellCorners(radius: 10)
        addShadow()
        contentView.addSubview(warrantyProductImageView)
        contentView.addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            warrantyProductImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            warrantyProductImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            warrantyProductImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            warrantyProductImageView.widthAnchor.constraint(equalTo: warrantyProductImageView.heightAnchor),
            
            warrantyName.heightAnchor.constraint(equalToConstant: 40),
            
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            infoStackView.leadingAnchor.constraint(equalTo: warrantyProductImageView.trailingAnchor, constant: 16)
        ])
    }
}
