//
//  DatePickerCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 24/06/2022.
//

/// Simple date picker cell

import UIKit

class DatePickerCell: UICollectionViewListCell {
    
    // MARK: - Internal properties
    
    static let identifier = "DatePickerCell"
    
    var warranty: Warranty? {
        didSet {
            refreshData()
        }
    }
    
    // MARK: - Private properties
    
    let datePicker = UIDatePicker()
    
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

extension DatePickerCell {
    func setupUI() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        // datePicker.addTarget(self, action: #selector(updateTimeIntervals), for: .editingDidEnd)
        
        contentView.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    func setupData() {
       
    }
}


