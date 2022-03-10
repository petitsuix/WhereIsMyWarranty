//
//  AdditionalNotesCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/03/2022.
//

import UIKit

class AdditionalNotesCell: UITableViewCell {
    
    static let identifier = Strings.additionalNotesCellIdentifier
    
    var textView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = nil
    }
}

extension AdditionalNotesCell {
    
    func setup() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Placeholder"
        textView.textColor = UIColor.lightGray

        // textView.placeholder = "Prix"
        contentView.backgroundColor = MWColor.white
        contentView.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            //heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
