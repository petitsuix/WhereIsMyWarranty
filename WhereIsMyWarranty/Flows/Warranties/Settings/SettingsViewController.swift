//
//  SettingsViewController.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 30/11/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: SettingsViewModel?
    private weak var coordinator: SettingsCoordinator?
    
    private let navBarAppearance = UINavigationBarAppearance()
    
    private let parentStackView = UIStackView()
    
    private let topPresentationView = UIView()
    private let topPresentationLabel = UILabel()
    
    private let cloudSyncLabel = UILabel()
    private let cloudSyncSwitch = UISwitch()
    private let cloudSyncStackView = UIStackView()
    
    private let notificationsLabel = UILabel()
    private let notificationsSwitch = UISwitch()
    private let notificationsStackView = UIStackView()
    
    private let aboutLabel = UILabel()
    private let versionLabel = UILabel()
    private let bottomBorder = UIView()
    
    private let privacyPolicyButton = UIButton()
    private let termsAndConditionsButton = UIButton()
    private let privacyAndTermsStackView = UIStackView()
    
    private let parentSettingsStackView = UIStackView()
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func goToPrivacyPolicyScreen() {
        viewModel?.showPrivacyPolicyScreen()
    }
    
    @objc func goToTermsAndConditionsScreen() {
        viewModel?.showTermsAndConditionsScreen()
    }
}

extension SettingsViewController {
    
    // MARK: - View configuration
    
    private func setup() {
        view.backgroundColor = MWColor.systemBackground
        self.title = Strings.settingsTitle
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: MWColor.bluegreyElement, .font: MWFont.navBar]
        navBarAppearance.backgroundColor = MWColor.systemBackground
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        topPresentationLabel.translatesAutoresizingMaskIntoConstraints = false
        topPresentationLabel.text = Strings.settingsPresentationLabel
        topPresentationLabel.textAlignment = .center
        topPresentationLabel.textColor = MWColor.systemBackground
        topPresentationLabel.numberOfLines = 0
        
        topPresentationView.backgroundColor = MWColor.bluegreyElement
        topPresentationView.roundingViewCorners(radius: 9)
        
        topPresentationView.addSubview(topPresentationLabel)
        
        notificationsLabel.text = Strings.notifications
        notificationsLabel.textColor = MWColor.bluegreyElement
        
        notificationsStackView.axis = .horizontal
        notificationsStackView.addArrangedSubview(notificationsLabel)
        notificationsStackView.addArrangedSubview(notificationsSwitch)
        
        cloudSyncLabel.text = Strings.cloudSync
        cloudSyncLabel.textColor = MWColor.bluegreyElement
        
        cloudSyncStackView.axis = .horizontal
        cloudSyncStackView.addArrangedSubview(cloudSyncLabel)
        cloudSyncStackView.addArrangedSubview(cloudSyncSwitch)
        
        parentSettingsStackView.axis = .vertical
        parentSettingsStackView.spacing = 24
        parentSettingsStackView.isUserInteractionEnabled = false
        parentSettingsStackView.alpha = 0.5
        
        parentSettingsStackView.addArrangedSubview(notificationsStackView)
        parentSettingsStackView.addArrangedSubview(cloudSyncStackView)
        parentSettingsStackView.addArrangedSubview(bottomBorder)
        
        bottomBorder.setBottomBorder()
        
        aboutLabel.text = Strings.about
        aboutLabel.font = MWFont.aboutLabel
        aboutLabel.textColor = MWColor.bluegreyElement
        aboutLabel.textAlignment = .center
        
        privacyPolicyButton.setTitle(Strings.privacyPolicy, for: .normal)
        privacyPolicyButton.setTitleColor(MWColor.bluegreyElement, for: .normal)
        privacyPolicyButton.setImage(MWImages.chevron, for: .normal)
        privacyPolicyButton.tintColor = MWColor.bluegreyElement
        privacyPolicyButton.semanticContentAttribute = .forceRightToLeft
        privacyPolicyButton.addTarget(self, action: #selector(goToPrivacyPolicyScreen), for: .touchUpInside)
        
        termsAndConditionsButton.setTitle(Strings.termsAndConditions, for: .normal)
        termsAndConditionsButton.setTitleColor(MWColor.bluegreyElement, for: .normal)
        termsAndConditionsButton.setImage(MWImages.chevron, for: .normal)
        termsAndConditionsButton.tintColor = MWColor.bluegreyElement
        termsAndConditionsButton.semanticContentAttribute = .forceRightToLeft
        termsAndConditionsButton.addTarget(self, action: #selector(goToTermsAndConditionsScreen), for: .touchUpInside)
        
        privacyAndTermsStackView.axis = .vertical
        privacyAndTermsStackView.spacing = 24
        privacyAndTermsStackView.alignment = .leading
       // privacyAndTermsStackView.alpha = 0.5
        
        privacyAndTermsStackView.addArrangedSubview(privacyPolicyButton)
        privacyAndTermsStackView.addArrangedSubview(termsAndConditionsButton)
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 24
        
        parentStackView.addArrangedSubview(topPresentationView)
        parentStackView.addArrangedSubview(parentSettingsStackView)
        parentStackView.addArrangedSubview(aboutLabel)
        parentStackView.addArrangedSubview(privacyAndTermsStackView)
        parentStackView.setCustomSpacing(32, after: parentSettingsStackView)
        parentStackView.setCustomSpacing(32, after: aboutLabel)
        
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.text = Bundle.main.prettyVersionString
        versionLabel.font = MWFont.versionLabel
        versionLabel.textColor = MWColor.bluegreyElement
        versionLabel.numberOfLines = 0
        versionLabel.textAlignment = .center
        
        view.addSubview(parentStackView)
        view.addSubview(versionLabel)
        
        NSLayoutConstraint.activate([
            topPresentationLabel.leadingAnchor.constraint(equalTo: topPresentationView.leadingAnchor, constant: 16),
            topPresentationLabel.trailingAnchor.constraint(equalTo: topPresentationView.trailingAnchor, constant: -16),
            topPresentationLabel.topAnchor.constraint(equalTo: topPresentationView.topAnchor, constant: 16),
            topPresentationLabel.bottomAnchor.constraint(equalTo: topPresentationView.bottomAnchor, constant: -16),
            
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}
