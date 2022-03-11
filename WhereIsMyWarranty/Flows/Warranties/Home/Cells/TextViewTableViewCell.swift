//
//  AdditionalNotesCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/03/2022.
//

import UIKit

final class FormTextView: UITextView {
    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    private let placeholderLabel = UILabel()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
    }

    // MARK: - Private methods

    private func setupView() {
        backgroundColor = .systemBackground
        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .label
        adjustsFontForContentSizeCategory = true
        textContainerInset = UIEdgeInsets(top: 8, left: 3, bottom: 8, right: 3)

        placeholderLabel.numberOfLines = 0
        placeholderLabel.textColor = .placeholderText
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .body)
        placeholderLabel.adjustsFontForContentSizeCategory = true
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1.0),
            placeholderLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1.0),
            placeholderLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -6),
            bottomAnchor.constraint(equalToSystemSpacingBelow: placeholderLabel.bottomAnchor, multiplier: 1.0)
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc
    private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}

class TextViewTableViewCell: UITableViewCell {
    
    static let identifier = Strings.additionalNotesCellIdentifier
    
    private let textView = FormTextView()
    
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
    
    var placeholder: String? {
        didSet {
            textView.placeholder = placeholder
        }
    }
}

extension TextViewTableViewCell {
    
    func setup() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = UIColor.lightGray
        backgroundColor = MWColor.white
        contentView.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
