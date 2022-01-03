//
//  NewWarrantyStepTwoViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 30/12/2021.
//

import UIKit

class NewWarrantyStepTwoViewController: UIViewController {

    let parentStackView = UIStackView()
    let addAFileTitleLabel = UILabel()
    let imageView = UIImageView()
    let selectImageButton = UIButton()
    let saveButton = UIButton()
    
    var viewModel: NewWarrantyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       // colorTests()
        // Do any additional setup after loading the view.
    }
    
    @objc func saveWarranty() {
        viewModel?.saveWarranty()
        print("dans le ViewVontroller")
        viewModel?.backToHome()
    }
    
    func setupView() {
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 40
        view.addSubview(parentStackView)
        
        addAFileTitleLabel.textColor = .black
        addAFileTitleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        addAFileTitleLabel.textAlignment = .center
        addAFileTitleLabel.text = "Ajouter un fichier"
        addAFileTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.label.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let buttonImage = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .small))
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        selectImageButton.setImage(buttonImage, for: .normal)
        selectImageButton.setTitle("Choisir une image", for: .normal)
        selectImageButton.arrangeButtonsImageAndText2(spacing: 6, contentYInset: 1.6)
        
        selectImageButton.setTitleColor(.label, for: .normal)
        selectImageButton.tintColor = MWColor.paleOrange
        
        saveButton.backgroundColor = MWColor.paleOrange
        saveButton.roundingViewCorners(radius: 8)
        saveButton.setTitle("Enregistrer", for: .normal)
        saveButton.addTarget(self, action: #selector(saveWarranty), for: .touchUpInside)
        saveButton.isUserInteractionEnabled = true
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        parentStackView.addArrangedSubview(addAFileTitleLabel)
        parentStackView.addArrangedSubview(imageView)
        parentStackView.addArrangedSubview(selectImageButton)
        
        view.addSubview(saveButton)
        activateConstraints()
    }
    
    func colorTests() {
        parentStackView.backgroundColor = .green
        addAFileTitleLabel.backgroundColor = .red
        imageView.backgroundColor = .yellow
        selectImageButton.backgroundColor = .orange
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            parentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            parentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            
            imageView.heightAnchor.constraint(equalToConstant: 320),
           // imageView.widthAnchor.constraint(equalToConstant: 120)
          //  parentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
            saveButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
