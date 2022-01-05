//
//  NewWarrantyStepTwoViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 30/12/2021.
//

import UIKit

class NewWarrantyStepTwoViewController: UIViewController {
    
    // MARK: - Properties

    let parentStackView = UIStackView()
    let addAFileTitleLabel = UILabel()
    let imageView = UIImageView()
    let selectImageButton = UIButton()
    let saveButton = UIButton()
    
    var viewModel: NewWarrantyViewModel?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       // colorTests()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - objc methods
    
    @objc func saveWarranty() {
        print("dans le ViewVontroller")
        viewModel?.saveWarranty()
    }
    
    // MARK: - Methods
    
    func setupView() {
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
        selectImageButton.addTarget(self, action: #selector(chooseAndDisplayImage), for: .touchUpInside)
        
        
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
    
    @objc func chooseAndDisplayImage() {
        setupAlert()
     }
    
    func setupAlert() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))
                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.openPhotoGallery()
                }))
                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

                self.present(alert, animated: true, completion: nil)
    }
    
    func openPhotoGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        imageView.image = selectedImage
        imageView.contentMode = .redraw
        picker.dismiss(animated: true, completion: nil)
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

extension NewWarrantyStepTwoViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
}
