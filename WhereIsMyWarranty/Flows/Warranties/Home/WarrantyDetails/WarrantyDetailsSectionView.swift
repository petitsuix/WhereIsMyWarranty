//
//  WarrantyDetailsSectionView.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 29/12/2021.
//

import UIKit

class WarrantyDetailsSectionView: UIView {
    
    // MARK: - Properties
    var sectionTitleText: String? {
        didSet {
            sectionTitle.text = sectionTitleText
        }
    }
    // FIXME: transformer en constantes et passer en private
    var stackView = UIStackView()
    var sectionTitle = UILabel()
    var firstRow = UILabel()
    var secondRow = UILabel()
    var thirdRow = UILabel()
    var fourthRow = UILabel()
    
    // MARK: - Methods
    
    func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        configureLabels()
        addSubview(stackView)
        activateConstraints()
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(sectionTitle)
        stackView.addArrangedSubview(firstRow)
        stackView.addArrangedSubview(secondRow)
        stackView.addArrangedSubview(thirdRow)
        stackView.addArrangedSubview(fourthRow)
    }
    
    private func configureLabels() {
        sectionTitle.font.withSize(15)
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        firstRow.translatesAutoresizingMaskIntoConstraints = false
        secondRow.translatesAutoresizingMaskIntoConstraints = false
        thirdRow.translatesAutoresizingMaskIntoConstraints = false
        fourthRow.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        ])
    }
}
