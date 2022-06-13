//
//  NewWarrantyStepTwoViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 30/12/2021.
//

import UIKit
import VisionKit

public enum PhotoMode {
    case productPhoto
    case invoicePhoto
}

class NewWarrantyPhotoViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var viewModel: NewWarrantyViewModel?
    var photoMode: PhotoMode = .productPhoto
    
    // MARK: - Private properties
    
    private let parentStackView = UIStackView()
    private let addAPhotoTitleLabel = UILabel()
    private let imageView = UIImageView()
    private let selectImageButton = UIButton()
    private let endCurrentScreenButton = ActionButton()
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupForProductPhotoViewController()
        setupForInvoicePhotoViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - objc methods
    
    @objc func goToAddInvoicePhotoScreen() {
        photoDidChange()
        if imageView.image == nil {
            guard let randomImage = MWImages.doggos.randomElement() else { return }
            viewModel?.productPhoto = randomImage.pngData()
        }
        viewModel?.goToAddInvoicePhotoScreen()
    }
    
    @objc func goToExtraInfoScreen() {
        photoDidChange()
        viewModel?.goToExtraInfoScreen()
    }
    
    @objc func chooseAndDisplayImage() {
        setupAlert()
    }
    
    // MARK: - Private methods
    
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
            self.open(sourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: Strings.galery, style: .default, handler: { _ in
            self.open(sourceType: .photoLibrary)
        }))
        if photoMode == .invoicePhoto {
        alert.addAction(UIAlertAction(title: Strings.scan, style: .default, handler: { _ in
            let scannerViewController = VNDocumentCameraViewController()
            scannerViewController.delegate = self
            self.present(scannerViewController, animated: true)
        }))
        }
        alert.addAction(UIAlertAction.init(title: Strings.cancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func open(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            alert(Strings.oops, Strings.accessingCameraFailed)
        }
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        let image = scan.imageOfPage(at: 0)
        guard let currentCGImage = image.cgImage else { return }
        let currentCIImage = CIImage(cgImage: currentCGImage)

        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(currentCIImage, forKey: "inputImage")
        filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")
        filter?.setValue(1.0, forKey: "inputIntensity")
        guard let outputImage = filter?.outputImage else { return }

        let context = CIContext()

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
            print(processedImage.size)
        }
        controller.dismiss(animated: true)
    }
    
    // MARK: - Image Picker Configuration
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        imageView.image = selectedImage?.resized(to: CGSize(width: 250, height: 320))
        picker.dismiss(animated: true, completion: nil)
    }
}

extension NewWarrantyPhotoViewController {
    
    // MARK: - View configuration
    
    private func setupView() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(aboutToCloseAlert))
        
        addAPhotoTitleLabel.textColor = MWColor.label
        addAPhotoTitleLabel.font = MWFont.addAPhotoTitle
        addAPhotoTitleLabel.textAlignment = .center
        addAPhotoTitleLabel.numberOfLines = 0
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = MWColor.label.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        selectImageButton.setImage(MWImages.selectAnImageButton, for: .normal)
        selectImageButton.setTitle(Strings.selectAnImage, for: .normal)
        
        selectImageButton.setTitleColor(MWColor.label, for: .normal)
        selectImageButton.tintColor = MWColor.paleOrange
        selectImageButton.addTarget(self, action: #selector(chooseAndDisplayImage), for: .touchUpInside)
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 32
        
        parentStackView.addArrangedSubview(addAPhotoTitleLabel)
        parentStackView.addArrangedSubview(imageView)
        parentStackView.addArrangedSubview(selectImageButton)
        
        endCurrentScreenButton.setup(title: Strings.nextStepButtonTitle)
        
        view.backgroundColor = MWColor.background
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
            endCurrentScreenButton.addTarget(self, action: #selector(goToAddInvoicePhotoScreen), for: .touchUpInside)
        }
    }
    
    private func setupForInvoicePhotoViewController() {
        if photoMode == .invoicePhoto {
            addAPhotoTitleLabel.text = Strings.addWarrantyProof
            endCurrentScreenButton.addTarget(self, action: #selector(goToExtraInfoScreen), for: .touchUpInside)
        }
    }
}

extension NewWarrantyPhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, VNDocumentCameraViewControllerDelegate {}
