//
//  SettingsViewController.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 30/11/2021.
//

import UIKit

class SettingsViewController: UIViewController {
  
    let navBarAppearance = UINavigationBarAppearance()
    
    let proView = UIView()
    let proLabel = UILabel()
    let proButton = UIButton()
    
    let cloudSyncLabel = UILabel()
    let cloudSyncSwitch = UISwitch()
    let notificationsLabel = UILabel()
    let notificationsSwitch = UISwitch()
    let aboutButton = UIButton()
    
    let cloudSyncStackView = UIStackView()
    let notificationsStackView = UIStackView()
    let parentSettingsStackView = UIStackView()
    
    override func viewWillAppear(_ animated: Bool) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = Strings.settingsTitle
        configureNavigationBar()
        proView.backgroundColor = #colorLiteral(red: 0.09810357541, green: 0.3023771942, blue: 0.3678480089, alpha: 1)
        proView.translatesAutoresizingMaskIntoConstraints = false
        proView.roundingViewCorners(radius: 9)
        view.addSubview(proView)
        
        proLabel.text = "Donnez nous un coup de pouce !\n En passant à la version pro."
        proLabel.textAlignment = .center
        proLabel.textColor = .white
        proLabel.numberOfLines = 0
        proLabel.translatesAutoresizingMaskIntoConstraints = false
        
        proButton.backgroundColor = #colorLiteral(red: 0.9260300994, green: 0.7213724256, blue: 0.593736887, alpha: 1)
        proButton.setTitle("Où est ma garantie PRO", for: .normal)
        proButton.titleLabel?.textColor = .white
        proButton.translatesAutoresizingMaskIntoConstraints = false
        proButton.roundingViewCorners(radius: 9)
        
        proView.addSubview(proLabel)
        proView.addSubview(proButton)
        
        
        
        cloudSyncLabel.text = "Synchronisation cloud"
        cloudSyncLabel.textColor = #colorLiteral(red: 0.09810357541, green: 0.3023771942, blue: 0.3678480089, alpha: 1)
        cloudSyncLabel.translatesAutoresizingMaskIntoConstraints = false
        
        notificationsLabel.text = "Notifications"
        notificationsLabel.textColor = #colorLiteral(red: 0.09810357541, green: 0.3023771942, blue: 0.3678480089, alpha: 1)
        notificationsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        aboutButton.setTitle("À propos", for: .normal)
        aboutButton.setTitleColor(UIColor(red: 0.09810357541, green: 0.3023771942, blue: 0.3678480089, alpha: 1), for: .normal)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        aboutButton.contentHorizontalAlignment = .left
        
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
        parentSettingsStackView.addArrangedSubview(cloudSyncStackView)
        parentSettingsStackView.addArrangedSubview(notificationsStackView)
        
        view.addSubview(parentSettingsStackView)
        view.addSubview(aboutButton)
        
        activateConstraints()
    }
    
    func configureNavigationBar() {
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.9285728335, green: 0.7623301148, blue: 0.6474828124, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func configureSwitchesStackView() {
        
    }
    
    func configureTitlesStackView() {
        
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            proView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            proView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            proView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            proView.heightAnchor.constraint(equalToConstant: 200),
            
            proLabel.leadingAnchor.constraint(equalTo: proView.leadingAnchor, constant: 20),
            proLabel.trailingAnchor.constraint(equalTo: proView.trailingAnchor, constant: -20),
            proLabel.topAnchor.constraint(equalTo: proView.topAnchor, constant: 20),
            
            proButton.leadingAnchor.constraint(equalTo: proView.leadingAnchor, constant: 55),
            proButton.trailingAnchor.constraint(equalTo: proView.trailingAnchor, constant: -55),
            proButton.bottomAnchor.constraint(equalTo: proView.bottomAnchor, constant: -20),
            proButton.heightAnchor.constraint(equalToConstant: 40),
            
            parentSettingsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            parentSettingsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            parentSettingsStackView.topAnchor.constraint(equalTo: proView.bottomAnchor, constant: 24),
            
            aboutButton.topAnchor.constraint(equalTo: notificationsStackView.bottomAnchor, constant: 24),
            aboutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            aboutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            aboutButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
