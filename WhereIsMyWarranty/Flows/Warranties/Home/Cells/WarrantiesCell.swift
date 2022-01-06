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
    
    // Overriding layoutSubviews if autoresizing and constraint-based behaviors of subviews do not offer the behavior we want.
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
        infoStackView.axis = .vertical
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.spacing = 8
        
        warrantyName.font = UIFont.boldSystemFont(ofSize: 18.5)
        warrantyName.translatesAutoresizingMaskIntoConstraints = false
        
        sellersNameAndLocation.text = "Apple Store" + ", " + "Lyon"
        sellersNameAndLocation.translatesAutoresizingMaskIntoConstraints = false
        
        remainingTime.text = "178 jours restants"
        remainingTime.translatesAutoresizingMaskIntoConstraints = false
        
        warrantyEnd.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.addArrangedSubview(warrantyName)
       // infoStackView.addArrangedSubview(sellersNameAndLocation)
        infoStackView.addArrangedSubview(remainingTime)
        infoStackView.addArrangedSubview(warrantyEnd)
        
        contentView.addSubview(infoStackView)
    }
    
    func refreshWarrantyData() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        guard let warrantyStart = warranty?.warrantyStart else { return }
        warrantyName.text = warranty?.name
        warrantyEnd.text = formatter1.string(from: warrantyStart)
    }
    
    // MARK: - Constraints setup
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            warrantyProductImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            warrantyProductImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            warrantyProductImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            warrantyProductImageView.widthAnchor.constraint(equalTo: warrantyProductImageView.heightAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
          //  infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            infoStackView.leadingAnchor.constraint(equalTo: warrantyProductImageView.trailingAnchor, constant: 8),
            
            warrantyName.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
