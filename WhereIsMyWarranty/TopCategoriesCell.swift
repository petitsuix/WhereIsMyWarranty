//
//  TopCategoriesCell.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 30/11/2021.
//

import UIKit

class TopCategoriesCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "custom"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.borderColor = #colorLiteral(red: 0.2539245784, green: 0.3356729746, blue: 0.3600735664, alpha: 1)
        contentView.layer.borderWidth = 1
        myLabel.textColor = #colorLiteral(red: 0.2539245784, green: 0.3356729746, blue: 0.3600735664, alpha: 1)
        myLabel.textAlignment = .center
        roundingCellCorners(radius: 8)
      //  contentView.layer.cornerRadius = 8
        contentView.addSubview(myLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
    func configureCell() {

    }
    
    /* func refreshData() {
        title.text = category?.name
    } */
    
}
