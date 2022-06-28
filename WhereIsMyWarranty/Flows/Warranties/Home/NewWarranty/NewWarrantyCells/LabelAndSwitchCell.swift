//
//  LabelAndSwitchCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 24/06/2022.
//

/// Cell configured with a Label to the left and a Switch button to the right

import UIKit

class LabelAndSwitchCell: UICollectionViewListCell {
    
    // MARK: - Internal properties
    
    static let identifier = "LabelAndSwitchCell"
    
    var warranty: Warranty? {
        didSet {
            refreshData()
        }
    }
    
    let label = UILabel()
    let switchButton = UISwitch()
    
    // MARK: - Private properties
    
    private let parentStackView = UIStackView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    // MARK: - Methods
    
    private func refreshData() {
        setupData()
    }
}

// MARK: - Configuration

extension LabelAndSwitchCell {
    func setupUI() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        accessories = [.customView(configuration: .init(customView: switchButton, placement: .trailing()))]
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
           // label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    func setupData() {
    }
}




