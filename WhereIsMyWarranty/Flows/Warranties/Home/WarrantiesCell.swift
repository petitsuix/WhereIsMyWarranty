//
//  WarrantiesCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/12/2021.
//

import UIKit

class WarrantiesCell: UICollectionViewCell {
    
    static let identifier = "WarrantiesCollectionViewCell"
    
    private var warrantyProductImageView = UIImageView()
    private var warrantyInfoStackView = UIStackView()
    
    private var warrantyCellInfo = UIStackView()
    private var warrantyName = UILabel()
    private var sellersNameAndLocation = UILabel()
    private var warrantyEnd = UILabel()
    private var remainingTime = UILabel()
    
    var warranty: Warranty? {
        didSet {
            refreshWarrantyData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.borderColor = #colorLiteral(red: 0.9529626966, green: 0.7530050874, blue: 0.6343111992, alpha: 1)
        contentView.layer.borderWidth = 3
        roundingCellCorners(radius: 10)
        addShadow()
        configureImageView()
        configureWarrantyCellInfoStackView()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureImageView() {
        let image = UIImage(named: "Launchscreen")
        warrantyProductImageView.image = image
        warrantyProductImageView.translatesAutoresizingMaskIntoConstraints = false
        warrantyProductImageView.roundingViewCorners(radius: 10)
        warrantyProductImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner] // to round specific corners (top left and bottom left)
        contentView.addSubview(warrantyProductImageView)
    }
    
    func configureWarrantyCellInfoStackView() {
        warrantyCellInfo.axis = .vertical
        warrantyCellInfo.translatesAutoresizingMaskIntoConstraints = false
        warrantyCellInfo.spacing = 8
        
        sellersNameAndLocation.text = "Apple Store" + ", " + "Lyon"
        remainingTime.text = "178 jours restants"
        warrantyEnd.text = "Garanti jusqu'au 14 avril 2022"
        warrantyCellInfo.addArrangedSubview(warrantyName)
        warrantyCellInfo.addArrangedSubview(sellersNameAndLocation)
        warrantyCellInfo.addArrangedSubview(remainingTime)
        warrantyCellInfo.addArrangedSubview(warrantyEnd)
        
        contentView.addSubview(warrantyCellInfo)
    }
    
    func refreshWarrantyData() {
        warrantyName.text = warranty?.name
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            warrantyProductImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            warrantyProductImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            warrantyProductImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            warrantyProductImageView.widthAnchor.constraint(equalTo: warrantyProductImageView.heightAnchor),
            
            warrantyCellInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            warrantyCellInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            warrantyCellInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            warrantyCellInfo.leadingAnchor.constraint(equalTo: warrantyProductImageView.trailingAnchor, constant: 8)
        ])
    }
    
}
