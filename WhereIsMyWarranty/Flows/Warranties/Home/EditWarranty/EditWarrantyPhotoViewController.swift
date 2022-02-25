//
//  EditWarrantyPhotoViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//

import UIKit

class EditWarrantyPhotoViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var photoMode: PhotoMode = .productPhoto
    var viewModel: EditWarrantyViewModel?
    
    // MARK: - Private properties
    
    private let parentStackView = UIStackView()
    private let addAPhotoTitleLabel = UILabel()
    private let imageView = UIImageView()
    private let selectImageButton = UIButton()
    private let endCurrentScreenButton = UIButton()
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupForProductPhotoViewController()
        setupForInvoicePhotoViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - objc methods
    
    @objc func goToEditInvoicePhotoScreen() {
        photoDidChange()
        viewModel?.goToEditInvoicePhotoScreen()
    }
    
    @objc func saveWarranty() {
        photoDidChange()
        viewModel?.saveEditedWarranty()
    }
    
    @objc func chooseAndDisplayImage() {
        setupAlert()
    }
    
    // MARK: - Methods
    
   private func photoDidChange() {
        if photoMode == .invoicePhoto {
            viewModel?.invoicePhoto = imageView.image?.pngData()
        } else {
            viewModel?.productPhoto = imageView.image?.pngData()
        }
    }
    
   private func setupAlert() {
       let alert = UIAlertController(title: Strings.selectAnImage, message: nil, preferredStyle: .actionSheet)
       alert.addAction(UIAlertAction(title: Strings.camera, style: .default, handler: { _ in
            self.openCamera()
        }))
       alert.addAction(UIAlertAction(title: Strings.galery, style: .default, handler: { _ in
            self.openPhotoGalery()
        }))
        alert.addAction(UIAlertAction.init(title: "Annuler", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openPhotoGalery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: Strings.oops, message: Strings.cantAccessLibrary, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: Strings.oops, message: Strings.noCameraDetected, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Image Picker Configuration
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        imageView.image = selectedImage?.resized(to: CGSize(width: 250, height: 320))
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditWarrantyPhotoViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - View configuration
    
    private func setupUI() {
        view.backgroundColor = MWColor.white
        
        addAPhotoTitleLabel.textColor = MWColor.black
        addAPhotoTitleLabel.font = MWFont.addAPhotoTitle
        addAPhotoTitleLabel.textAlignment = .center
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = MWColor.black.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        selectImageButton.setImage(MWImages.selectAnImageButton, for: .normal)
        selectImageButton.setTitle(Strings.selectAnImage, for: .normal)
        selectImageButton.arrangeButtonsImageAndTextY(spacing: 6, contentYInset: 1.6)
        
        selectImageButton.setTitleColor(MWColor.black, for: .normal)
        selectImageButton.tintColor = MWColor.paleOrange
        selectImageButton.addTarget(self, action: #selector(chooseAndDisplayImage), for: .touchUpInside)
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 32
        
        parentStackView.addArrangedSubview(addAPhotoTitleLabel)
        parentStackView.addArrangedSubview(imageView)
        parentStackView.addArrangedSubview(selectImageButton)
        
        endCurrentScreenButton.translatesAutoresizingMaskIntoConstraints = false
        endCurrentScreenButton.backgroundColor = MWColor.paleOrange
        endCurrentScreenButton.roundingViewCorners(radius: 8)
        endCurrentScreenButton.isUserInteractionEnabled = true
        
        view.addSubview(parentStackView)
        view.addSubview(endCurrentScreenButton)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 320),
            
            selectImageButton.heightAnchor.constraint(equalToConstant: 30),
        
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            parentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            parentStackView.bottomAnchor.constraint(lessThanOrEqualTo: endCurrentScreenButton.topAnchor, constant: -24),
            
            endCurrentScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endCurrentScreenButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            endCurrentScreenButton.heightAnchor.constraint(equalToConstant: 55),
            endCurrentScreenButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func setupForProductPhotoViewController() {
        if photoMode == .productPhoto {
            addAPhotoTitleLabel.text = Strings.addProductPhoto
            endCurrentScreenButton.setTitle(Strings.nextStepButtonTitle, for: .normal)
            endCurrentScreenButton.addTarget(self, action: #selector(goToEditInvoicePhotoScreen), for: .touchUpInside)
            if let productPhoto = viewModel?.warranty.productPhoto {
                imageView.image = UIImage(data: productPhoto)
            }
        }
    }
    
    private func setupForInvoicePhotoViewController() {
        if photoMode == .invoicePhoto {
            addAPhotoTitleLabel.text = Strings.addInvoicePhoto
            endCurrentScreenButton.setTitle(Strings.saveButtonTitle, for: .normal)
            endCurrentScreenButton.addTarget(self, action: #selector(saveWarranty), for: .touchUpInside)
            if let invoicePhoto = viewModel?.warranty.invoicePhoto {
                imageView.image = UIImage(data: invoicePhoto)
            }
        }
    }
}
