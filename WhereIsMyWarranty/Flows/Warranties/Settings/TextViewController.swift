//
//  TextViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 29/04/2022.
//

import UIKit

public enum ControllerType {
    case privacyPolicy
    case termsAndConditions
}

class TextViewController: UIViewController {
    
    var viewModel: SettingsViewModel?
    
    var controllerType: ControllerType = .privacyPolicy
    
    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupForPrivacyPolicy()
        setupForTermsAndConditions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.contentOffset = .zero
    }
    
    func setup() {
        textView.isEditable = false
        textView.isSelectable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])
    }
    
    //    func setupForPrivacyPolicy() {
    //        if controllerType == .privacyPolicy {
    //            textView.text = Strings.privacyPolicyBodyText
    //        }
    //    }
    
    func setupForPrivacyPolicy() {
        self.title = "Politique de confidentialité"
        if controllerType == .privacyPolicy {
            if let textFile = Bundle.main.url(forResource: "privacy_policy", withExtension: "txt") {
                do {
                    let content = try String(contentsOf: textFile)
                    textView.text = content
                } catch {
                    textView.text = "Could not load text"
                }
            }
        }
    }
    
    func setupForTermsAndConditions() {
        self.title = "Conditions générales"
        if controllerType == .termsAndConditions {
            if let textFile = Bundle.main.url(forResource: "terms_and_conditions", withExtension: "txt") {
                do {
                    let content = try String(contentsOf: textFile)
                    textView.text = content
                } catch {
                    textView.text = "Could not load text"
                }
            }
        }
    }
    
}
