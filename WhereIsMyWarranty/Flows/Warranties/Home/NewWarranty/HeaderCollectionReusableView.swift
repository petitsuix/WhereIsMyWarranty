//
//  SupplementaryViewProvider.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 28/06/2022.
//

import Foundation
import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: HeaderCollectionReusableView.self)
    }
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    func configure(with item: Configuration) {
        titleLabel.text = item.title
        titleLabel.isHidden = (item.title == nil)
    }
    
    func setupView() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension HeaderCollectionReusableView {
    struct Configuration {
        let title: String?
        
        init(title: String?) {
            self.title = title
        }
    }
}
