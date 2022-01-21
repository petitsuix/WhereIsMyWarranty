//
//  WarrantiesCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/12/2021.
//

import UIKit

class WarrantiesCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "WarrantiesCollectionViewCell"
    
    private var warrantyProductImageView = UIImageView()
    private var infoStackView = UIStackView()
    private var warrantyName = UILabel()
    private var sellersNameAndLocation = UILabel()
    private var warrantyEnd = UILabel()
    private var remainingTime = UILabel()
    
    var warranty: Warranty? {
        didSet {
            refreshWarrantyData()
        }
    }
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.borderColor = MWColor.bluegrey.cgColor
        contentView.layer.borderWidth = 1.7
        roundingCellCorners(radius: 10)
        addShadow()
        configureImageView()
        configureWarrantyCellInfoStackView()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Overriding layoutSubviews if autoresizing and constraint-based behaviors of subviews do not offer the behavior we want.
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureImageView() {
        warrantyProductImageView.translatesAutoresizingMaskIntoConstraints = false
        warrantyProductImageView.roundingViewCorners(radius: 10)
        warrantyProductImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner] // to round specific corners (top left and bottom left)
        contentView.addSubview(warrantyProductImageView)
    }
    
    func configureWarrantyCellInfoStackView() {
        infoStackView.axis = .vertical
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.spacing = 8
        
        warrantyName.font = UIFont.boldSystemFont(ofSize: 20)
        warrantyName.translatesAutoresizingMaskIntoConstraints = false
        
        sellersNameAndLocation.text = "Apple Store" + ", " + "Lyon"
        sellersNameAndLocation.translatesAutoresizingMaskIntoConstraints = false
        
        remainingTime.translatesAutoresizingMaskIntoConstraints = false
        
        warrantyEnd.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.addArrangedSubview(warrantyName)
        // infoStackView.addArrangedSubview(sellersNameAndLocation)
        infoStackView.addArrangedSubview(remainingTime)
        infoStackView.addArrangedSubview(warrantyEnd)
        
        contentView.addSubview(infoStackView)
    }
    
    func refreshWarrantyData() {
        guard let invoicePhoto = warranty?.productPhoto else { return }
        warrantyProductImageView.image = UIImage(data: invoicePhoto)
        
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        warrantyName.text = warranty?.name
        
        if warranty?.lifetimeWarranty == false {
            warrantyEnd.isHidden = false
            guard let warrantyEndDate = warranty?.warrantyEnd else { return }
            warrantyEnd.text = "Garanti jusqu'au \(formatter1.string(from: warrantyEndDate))"
            remainingTime.text = getRemainingTimeFromEndDate() + " jours restants"
        } else {
            warrantyEnd.isHidden = true
            remainingTime.text = Strings.lifetimeWarrantyDefaultText
        }
    }
    
    func getRemainingTimeFromEndDate() -> String {
        let calendar = NSCalendar.current
        
        guard let warrantyEnd = warranty?.warrantyEnd else { return "000" }
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: warrantyEnd)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        guard let remainingDays = components.day else { return "000" }
        return String("\(remainingDays)")
    }
    
    // MARK: - Constraints setup
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            warrantyProductImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            warrantyProductImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            warrantyProductImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            warrantyProductImageView.widthAnchor.constraint(equalTo: warrantyProductImageView.heightAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            infoStackView.leadingAnchor.constraint(equalTo: warrantyProductImageView.trailingAnchor, constant: 16),
            
            warrantyName.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
