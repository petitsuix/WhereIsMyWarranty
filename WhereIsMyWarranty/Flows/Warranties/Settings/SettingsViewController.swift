//
//  SettingsViewController.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 30/11/2021.
//

import UIKit

class SettingsViewController: UIViewController {
  
   private let navBarAppearance = UINavigationBarAppearance()
    
    private let parentStackView = UIStackView()
    
    private let proView = UIView()
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
    
    override func viewWillAppear(_ animated: Bool) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // FIXME: gérer le dark mode ?
        view.backgroundColor = .systemBackground
        self.title = Strings.settingsTitle
        navBarAppearance.titleTextAttributes = [.foregroundColor: MWColor.bluegrey, .font: UIFont.systemFont(ofSize: 19, weight: .semibold)]
        
        topPresentationLabel.text = Strings.settingsPresentationLabel
        topPresentationLabel.textAlignment = .center
        topPresentationLabel.textColor = .white
        topPresentationLabel.numberOfLines = 0
        topPresentationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        configureNavigationBar()
        proView.backgroundColor = #colorLiteral(red: 0.09810357541, green: 0.3023771942, blue: 0.3678480089, alpha: 1)
        proView.translatesAutoresizingMaskIntoConstraints = false
        proView.roundingViewCorners(radius: 9)
        
        proView.addSubview(topPresentationLabel)
        
        cloudSyncLabel.text = Strings.cloudSync
        cloudSyncLabel.textColor = #colorLiteral(red: 0.09810357541, green: 0.3023771942, blue: 0.3678480089, alpha: 1)
        cloudSyncLabel.translatesAutoresizingMaskIntoConstraints = false
        
        notificationsLabel.text = Strings.notifications
        notificationsLabel.textColor = #colorLiteral(red: 0.09810357541, green: 0.3023771942, blue: 0.3678480089, alpha: 1)
        notificationsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cloudSyncStackView.axis = .horizontal
        cloudSyncStackView.translatesAutoresizingMaskIntoConstraints = false
        cloudSyncStackView.addArrangedSubview(cloudSyncLabel)
        cloudSyncStackView.addArrangedSubview(cloudSyncSwitch)
        
        notificationsStackView.axis = .horizontal
        notificationsStackView.translatesAutoresizingMaskIntoConstraints = false
        notificationsStackView.addArrangedSubview(notificationsLabel)
        notificationsStackView.addArrangedSubview(notificationsSwitch)
        
        parentSettingsStackView.axis = .vertical
        parentSettingsStackView.spacing = 24
        parentSettingsStackView.translatesAutoresizingMaskIntoConstraints = false
        parentSettingsStackView.isUserInteractionEnabled = false
        parentSettingsStackView.alpha = 0.5

        parentSettingsStackView.addArrangedSubview(notificationsStackView)
        parentSettingsStackView.addArrangedSubview(cloudSyncStackView)
        parentSettingsStackView.addArrangedSubview(bottomBorder)
       
        bottomBorder.setBottomBorder()
        
        aboutLabel.text = Strings.about
        aboutLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        aboutLabel.textColor = MWColor.bluegrey
        aboutLabel.textAlignment = .center
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        
        privacyPolicyButton.setTitle(Strings.privacyPolicy, for: .normal)
        privacyPolicyButton.setImage(UIImage(systemName: Strings.chevron), for: .normal)
        privacyPolicyButton.tintColor = MWColor.bluegrey
        privacyPolicyButton.semanticContentAttribute = .forceRightToLeft
        privacyPolicyButton.setTitleColor(MWColor.bluegrey, for: .normal)
        
        termsAndConditionsButton.setTitle(Strings.termsAndConditions, for: .normal)
        termsAndConditionsButton.setImage(UIImage(systemName: Strings.chevron), for: .normal)
        termsAndConditionsButton.tintColor = MWColor.bluegrey
        termsAndConditionsButton.semanticContentAttribute = .forceRightToLeft
        termsAndConditionsButton.setTitleColor(MWColor.bluegrey, for: .normal)
 
        privacyAndTermsStackView.axis = .vertical
        privacyAndTermsStackView.spacing = 24
        privacyAndTermsStackView.alignment = .leading
        privacyAndTermsStackView.isUserInteractionEnabled = false
        privacyAndTermsStackView.alpha = 0.5
        
        privacyAndTermsStackView.addArrangedSubview(privacyPolicyButton)
        privacyAndTermsStackView.addArrangedSubview(termsAndConditionsButton)

        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 24
        
        parentStackView.addArrangedSubview(proView)
        parentStackView.addArrangedSubview(parentSettingsStackView)
        parentStackView.addArrangedSubview(aboutLabel)
        parentStackView.addArrangedSubview(privacyAndTermsStackView)
        parentStackView.setCustomSpacing(32, after: parentSettingsStackView)
        parentStackView.setCustomSpacing(32, after: aboutLabel)
        
        versionLabel.text = Strings.version
        versionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        versionLabel.textColor = MWColor.bluegrey
        versionLabel.numberOfLines = 0
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.textAlignment = .center
        
        view.addSubview(parentStackView)
        view.addSubview(versionLabel)
    
        activateConstraints()
    }
    
    func configureNavigationBar() {
        navBarAppearance.backgroundColor = MWColor.paleOrange
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([

            topPresentationLabel.leadingAnchor.constraint(equalTo: proView.leadingAnchor, constant: 16),
            topPresentationLabel.trailingAnchor.constraint(equalTo: proView.trailingAnchor, constant: -16),
            topPresentationLabel.topAnchor.constraint(equalTo: proView.topAnchor, constant: 16),
            topPresentationLabel.bottomAnchor.constraint(equalTo: proView.bottomAnchor, constant: -16),
            
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}
