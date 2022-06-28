//
//  NewWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 07/12/2021.
//
//swiftlint:disable file_length

import UIKit

class NewWarrantyProductInfoViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum Section: Int, CaseIterable {
        case warrantyTitle
        case warrantyStart
        case validityLength
        case warrantyExpirationSection
        
        var headerTitle: String? {
            switch self {
            case .warrantyTitle:
                return Strings.warrantyInfoTitle
            case .warrantyStart:
                return Strings.warrantyStartDate
            case .validityLength:
                return Strings.validityLength
            case .warrantyExpirationSection:
                return nil
            }
        }
    }
    
    private enum Item: Hashable {
        case warrantyTitleField
        case datePicker
        case lifetimeWarranty
        case yearsStepper
        case monthsStepper
        case weeksStepper
        case reminder
        case warrantyExpirationItem(expirationDate: String)
    }
    
    // MARK: - Internal properties
    
    var viewModel: NewWarrantyViewModel?
    
    // MARK: - Private properties
    
    private let scrollView = UIScrollView()
    private let parentStackView = UIStackView()
    
    private let nameAndStartDateStackView = UIStackView()
    
    private var nameStackView = UIStackView()
    private let screenTitle = UILabel()
    private let nameField = UITextField()
    
    private let startDateStackView = UIStackView()
    private let startDateTitle = UILabel()
    private let datePicker = UIDatePicker()
    
    private let notificationStackView = UIStackView()
    private let notificationTitle = UILabel()
    private let notificationSwitch = UISwitch()
    
    private let customLengthStackView = UIStackView()
    private let validityLengthTitle = UILabel()
    
    private let lifetimeWarrantyStackView = UIStackView()
    private let lifetimeWarrantyTitle = UILabel()
    private let lifetimeWarrantySwitch = UISwitch()
    private let yearsView = TextWithStepperView()
    private let monthsView = TextWithStepperView()
    private let weeksView = TextWithStepperView()
    
    //private let endDateLabel = UILabel()
    private let endCurrentScreenButton = ActionButton()
    
    private var updatedDate: Date?
    private var endDate: String = ""
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var collectionView: UICollectionView!
    
    // MARK: - View life cycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideKeyboardWhenTappedAround()
        configureDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        canGoToNextStep(canSave: false)
    }
    
    // MARK: - objc methods
    
    @objc func nameTextfieldDidChange(textfield: UITextField) {
        viewModel?.name = textfield.text
    }
    
    @objc func lifetimeSwitchAction() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.yearsView.isHidden.toggle()
            self.monthsView.isHidden.toggle()
            self.weeksView.isHidden.toggle()
            self.notificationStackView.isHidden.toggle()
        }, completion: nil)
        if lifetimeWarrantySwitch.isOn {
            endDate = Strings.lifetimeWarrantyDefaultText
        } else {
            updateDateAfterTurningSwitchOff()
        }
    }
    
    @objc func notificationSwitchAction() {
        if notificationSwitch.isOn {
            NotificationService.requestNotificationAuthorization()
            viewModel?.areNotificationsEnabled = true
        } else {
            viewModel?.areNotificationsEnabled = false
        }
    }
    
    /// In case the user changes the initial warranty start date in the date-picker, calling the 3 update methods in the function below will ensure that the endDate is re-calculated according to the stepper values that he previously gave, if any.
    @objc func updateTimeIntervals() {
        updatedDate = datePicker.date
        if weeksView.timeUnitAmount.text != "0" {
            updateWeeks()
        }
        if monthsView.timeUnitAmount.text != "0" {
            updateMonths()
        }
        if yearsView.timeUnitAmount.text != "0" {
            updateYears()
        }
        if lifetimeWarrantySwitch.isOn {
            endDate = Strings.lifetimeWarrantyDefaultText
        }
    }
    
    @objc func goToAddProductPhotoScreen() {
        viewModel?.startDate = datePicker.date
        viewModel?.isLifetimeWarranty = (lifetimeWarrantySwitch.isOn ? true : false)
        viewModel?.endDate = updatedDate
        viewModel?.goToAddProductPhotoScreen()
    }
    
    @objc func weeksStepperTapped() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        updatedDate = updatedDate?.adding(.day, value: (weeksView.didIncrementStepper ? 7 : -7))
        if let updatedDate = updatedDate {
            endDate = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    @objc func monthsStepperTapped() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        updatedDate = updatedDate?.adding(.month, value: (monthsView.didIncrementStepper ? 1 : -1))
        if let updatedDate = updatedDate {
            endDate = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    @objc func yearsStepperTapped() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        updatedDate = updatedDate?.adding(.year, value: (yearsView.didIncrementStepper ? 1 : -1))
        if let updatedDate = updatedDate {
            endDate = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    // MARK: - Methods
    
    func canGoToNextStep(canSave: Bool) {
        if canSave {
            endCurrentScreenButton.isEnabled = true
            endCurrentScreenButton.alpha = 1
        } else {
            endCurrentScreenButton.isEnabled = false
            endCurrentScreenButton.alpha = 0.5
        }
    }
    
    // MARK: - Private methods
    
    private func updateWeeks() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if let timeUnitAmount = weeksView.timeUnitAmount.text {
            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
                updatedDate = updatedDate?.adding(.day, value: timeUnitAmountAsInt * 7)
            }
        }
        if let updatedDate = updatedDate {
            endDate = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    private func updateMonths() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if let timeUnitAmount = monthsView.timeUnitAmount.text {
            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
                updatedDate = updatedDate?.adding(.month, value: timeUnitAmountAsInt)
            }
        }
        if let updatedDate = updatedDate {
            endDate = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    private func updateYears() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if let timeUnitAmount = yearsView.timeUnitAmount.text {
            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
                updatedDate = updatedDate?.adding(.year, value: timeUnitAmountAsInt)
            }
        }
        if let updatedDate = updatedDate {
            endDate = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    private func updateDateAfterTurningSwitchOff() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if let updatedDate = updatedDate {
            if weeksView.timeUnitAmount.text == "0" && monthsView.timeUnitAmount.text == "0" && yearsView.timeUnitAmount.text == "0" {
                endDate = Strings.productCoveredUntil
            } else {
                endDate = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            }
        }
    }
    
    private func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .warrantyTitleField:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.warrantyTitleFieldCellIdentifier, for: indexPath) as? WarrantyTitleFieldCell
                cell?.nameField.addTarget(self, action: #selector(self.nameTextfieldDidChange), for: .editingChanged)
                return cell
            case .datePicker:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.datePickerCellIdentifier, for: indexPath) as? DatePickerCell
                // cell?.comic = result
                cell?.datePicker.addTarget(self, action: #selector(self.updateTimeIntervals), for: .editingDidEnd)
                return cell
            case .lifetimeWarranty:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.labelAndSwitchCellIdentifier, for: indexPath) as? LabelAndSwitchCell
                cell?.label.text = Strings.lifetimeWarranty
                cell?.switchButton.addTarget(self, action: #selector(self.lifetimeSwitchAction), for: .valueChanged)
                return cell
            case .yearsStepper:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.timeSpanWithStepperCellIdentifier, for: indexPath) as? TimeSpanWithStepperCell
                cell?.timeUnitTitle.text = Strings.years
                cell?.stepper.addTarget(self, action: #selector(self.yearsStepperTapped), for: .valueChanged)
                return cell
            case .monthsStepper:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.timeSpanWithStepperCellIdentifier, for: indexPath) as? TimeSpanWithStepperCell
                cell?.timeUnitTitle.text = Strings.months
                cell?.stepper.addTarget(self, action: #selector(self.monthsStepperTapped), for: .valueChanged)
                return cell
            case .weeksStepper:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.timeSpanWithStepperCellIdentifier, for: indexPath) as? TimeSpanWithStepperCell
                cell?.timeUnitTitle.text = Strings.weeks
                cell?.stepper.addTarget(self, action: #selector(self.weeksStepperTapped), for: .valueChanged)
                return cell
            case .reminder:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.labelAndSwitchCellIdentifier, for: indexPath) as? LabelAndSwitchCell
                cell?.label.text = Strings.reminder
                cell?.label.font = MWFont.modalSubtitles
                cell?.switchButton.addTarget(self, action: #selector(self.notificationSwitchAction), for: .valueChanged)
                return cell
            case .warrantyExpirationItem(let expirationDate):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.warrantyExpirationDateCellIdentifier, for: indexPath) as? WarrantyExpirationDateCell
                cell?.endDateLabel.text = expirationDate
                return cell
            }
        })
        let sectionHeaderReusableViewRegistration = UICollectionView.SupplementaryRegistration<HeaderCollectionReusableView>(elementKind: HeaderCollectionReusableView.reuseIdentifier) { [weak self] reusableView, _, indexPath in
            guard let self = self,
                  let section = self.diffableDataSource?.snapshot().sectionIdentifiers[indexPath.section],
                  let title = section.headerTitle else { return }
            reusableView.configure(with: .init(title: title))
        }
        diffableDataSource.supplementaryViewProvider = { collectionView, identifier, indexPath -> UICollectionReusableView in
            switch identifier {
            case HeaderCollectionReusableView.reuseIdentifier:
                return collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderReusableViewRegistration, for: indexPath)
            default :
                fatalError("Unknown supplementary header view kind")
            }
        }
        let snapshot = createSnapshot()
        diffableDataSource.apply(snapshot)
    }
    
    private func createSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([Section.warrantyTitle, Section.warrantyStart, Section.validityLength, Section.warrantyExpirationSection])
        snapshot.appendItems([.warrantyTitleField], toSection: .warrantyTitle)
        snapshot.appendItems([.datePicker], toSection: .warrantyStart)
        snapshot.appendItems([.lifetimeWarranty, .yearsStepper, .monthsStepper, .weeksStepper, .reminder], toSection: .warrantyStart)
        snapshot.appendItems([.warrantyExpirationItem(expirationDate: endDate)], toSection: .warrantyExpirationSection)
        return snapshot
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = MWColor.extraInfoCellBackground
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)
            let sectionItem = self.diffableDataSource.snapshot().sectionIdentifiers[sectionIndex]
            if sectionItem.headerTitle != nil {
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(24))
                let boundaryHeaderView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: HeaderCollectionReusableView.reuseIdentifier, alignment: .top)
                section.boundarySupplementaryItems = [boundaryHeaderView]
            }
            return section
        }
        return layout
    }
}

extension NewWarrantyProductInfoViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.section == Section.warrantyExpirationSection.rawValue {
//            return CGSize(width: view.frame.size.width, height: 90)
//        }
//    }
}

private extension NewWarrantyProductInfoViewController {
    private class DataSource: UICollectionViewDiffableDataSource<Section, Item> {
//        collecion
//        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//            let sectionKind = Section(rawValue: section)
//            return sectionKind?.headerTitle
//        }
//        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//            return false
//        }
    }
}

extension NewWarrantyProductInfoViewController {
    
    // MARK: - View configuration
    
    enum Constant {
        static let warrantyTitleFieldCellIdentifier = "WarrantyTitleFieldCell"
        static let datePickerCellIdentifier = "DatePickerCell"
        static let labelAndSwitchCellIdentifier = "LabelAndSwitchCell"
        static let timeSpanWithStepperCellIdentifier = "TimeSpanWithStepperCell"
        static let warrantyExpirationDateCellIdentifier = "WarrantyExpirationDateCell"
    }
    
    private func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(aboutToCloseAlert))
        
        //let collectionViewLayout = UICollectionViewFlowLayout()
        //collectionViewLayout.scrollDirection = .vertical
        //collectionViewLayout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.width/2)
        //collectionViewLayout.minimumLineSpacing = 32
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier)
        collectionView.register(WarrantyTitleFieldCell.self, forCellWithReuseIdentifier: WarrantyTitleFieldCell.identifier)
        collectionView.register(DatePickerCell.self, forCellWithReuseIdentifier: DatePickerCell.identifier)
        collectionView.register(LabelAndSwitchCell.self, forCellWithReuseIdentifier: LabelAndSwitchCell.identifier)
        collectionView.register(TimeSpanWithStepperCell.self, forCellWithReuseIdentifier: TimeSpanWithStepperCell.identifier)
        collectionView.register(WarrantyExpirationDateCell.self, forCellWithReuseIdentifier: WarrantyExpirationDateCell.identifier)

        endCurrentScreenButton.setup(title: Strings.nextStepButtonTitle)
        endCurrentScreenButton.addTarget(self, action: #selector(goToAddProductPhotoScreen), for: .touchUpInside)
        
        view.backgroundColor = MWColor.background
        view.addSubview(collectionView)
        view.addSubview(endCurrentScreenButton)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
           
            endCurrentScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endCurrentScreenButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            endCurrentScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            endCurrentScreenButton.heightAnchor.constraint(equalToConstant: 55),
            endCurrentScreenButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
}


//import UIKit
//
//class NewWarrantyProductInfoViewController: UIViewController {
//
//    // MARK: - Internal properties
//
//    var viewModel: NewWarrantyViewModel?
//
//    // MARK: - Private properties
//
//    private let scrollView = UIScrollView()
//    private let parentStackView = UIStackView()
//
//    private let nameAndStartDateStackView = UIStackView()
//
//    private var nameStackView = UIStackView()
//    private let screenTitle = UILabel()
//    private let nameField = UITextField()
//
//    private let startDateStackView = UIStackView()
//    private let startDateTitle = UILabel()
//    private let datePicker = UIDatePicker()
//
//    private let notificationStackView = UIStackView()
//    private let notificationTitle = UILabel()
//    private let notificationSwitch = UISwitch()
//
//    private let customLengthStackView = UIStackView()
//    private let validityLengthTitle = UILabel()
//
//    private let lifetimeWarrantyStackView = UIStackView()
//    private let lifetimeWarrantyTitle = UILabel()
//    private let lifetimeWarrantySwitch = UISwitch()
//    private let yearsView = TextWithStepperView()
//    private let monthsView = TextWithStepperView()
//    private let weeksView = TextWithStepperView()
//
//    private let endDateLabel = UILabel()
//    private let endCurrentScreenButton = ActionButton()
//
//    private var updatedDate: Date?
//
//    // MARK: - View life cycle methods
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        canGoToNextStep(canSave: false)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.hideKeyboardWhenTappedAround()
//    }
//
//    // MARK: - objc methods
//
//    @objc func nameTextfieldDidChange(textfield: UITextField) {
//        viewModel?.name = textfield.text
//    }
//
//    @objc func lifetimeSwitchAction() {
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//            self.yearsView.isHidden.toggle()
//            self.monthsView.isHidden.toggle()
//            self.weeksView.isHidden.toggle()
//            self.notificationStackView.isHidden.toggle()
//        }, completion: nil)
//        if lifetimeWarrantySwitch.isOn {
//            endDateLabel.text = Strings.lifetimeWarrantyDefaultText
//        } else {
//            updateDateAfterTurningSwitchOff()
//        }
//    }
//
//    @objc func notificationSwitchAction() {
//        if notificationSwitch.isOn {
//            NotificationService.requestNotificationAuthorization()
//            viewModel?.areNotificationsEnabled = true
//        } else {
//            viewModel?.areNotificationsEnabled = false
//        }
//    }
//
//    // In case the user changes the initial warranty start date in the date-picker, calling the 3 update methods below will ensure that the endDate is re-calculated according to the stepper values that he previously gave, if any.
//    @objc func updateTimeIntervals() {
//        updatedDate = datePicker.date
//        if weeksView.timeUnitAmount.text != "0" {
//            updateWeeks()
//        }
//        if monthsView.timeUnitAmount.text != "0" {
//            updateMonths()
//        }
//        if yearsView.timeUnitAmount.text != "0" {
//            updateYears()
//        }
//        if lifetimeWarrantySwitch.isOn {
//            endDateLabel.text = Strings.lifetimeWarrantyDefaultText
//        }
//    }
//
//    @objc func goToAddProductPhotoScreen() {
//        //FIXME: a assigner à l'action d'un bouton switch
//
//        viewModel?.startDate = datePicker.date
//        viewModel?.isLifetimeWarranty = (lifetimeWarrantySwitch.isOn ? true : false)
//        viewModel?.endDate = updatedDate
//        viewModel?.goToAddProductPhotoScreen()
//    }
//
//    @objc func weeksStepperTapped() {
//        if updatedDate == nil {
//            updatedDate = datePicker.date
//        }
//        let formatter1 = DateFormatter()
//        formatter1.dateStyle = .full
//        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
//        updatedDate = updatedDate?.adding(.day, value: (weeksView.didIncrementStepper ? 7 : -7))
//        if let updatedDate = updatedDate {
//            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
//            self.updatedDate = updatedDate
//        }
//    }
//
//    @objc func monthsStepperTapped() {
//        if updatedDate == nil {
//            updatedDate = datePicker.date
//        }
//        let formatter1 = DateFormatter()
//        formatter1.dateStyle = .full
//        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
//        updatedDate = updatedDate?.adding(.month, value: (monthsView.didIncrementStepper ? 1 : -1))
//        if let updatedDate = updatedDate {
//            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
//            self.updatedDate = updatedDate
//        }
//    }
//
//    @objc func yearsStepperTapped() {
//        if updatedDate == nil {
//            updatedDate = datePicker.date
//        }
//        let formatter1 = DateFormatter()
//        formatter1.dateStyle = .full
//        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
//        updatedDate = updatedDate?.adding(.year, value: (yearsView.didIncrementStepper ? 1 : -1))
//        if let updatedDate = updatedDate {
//            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
//            self.updatedDate = updatedDate
//        }
//    }
//
//    // MARK: - Methods
//
//    func canGoToNextStep(canSave: Bool) {
//        if canSave {
//            endCurrentScreenButton.isEnabled = true
//            endCurrentScreenButton.alpha = 1
//        } else {
//            endCurrentScreenButton.isEnabled = false
//            endCurrentScreenButton.alpha = 0.5
//        }
//    }
//
//    // MARK: - Private methods
//
//    private func updateWeeks() {
//        let formatter1 = DateFormatter()
//        formatter1.dateStyle = .full
//        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
//        if let timeUnitAmount = weeksView.timeUnitAmount.text {
//            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
//                updatedDate = updatedDate?.adding(.day, value: timeUnitAmountAsInt * 7)
//            }
//        }
//        if let updatedDate = updatedDate {
//            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
//            self.updatedDate = updatedDate
//        }
//    }
//
//    private func updateMonths() {
//        let formatter1 = DateFormatter()
//        formatter1.dateStyle = .full
//        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
//        if let timeUnitAmount = monthsView.timeUnitAmount.text {
//            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
//                updatedDate = updatedDate?.adding(.month, value: timeUnitAmountAsInt)
//            }
//        }
//        if let updatedDate = updatedDate {
//            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
//            self.updatedDate = updatedDate
//        }
//    }
//
//    private func updateYears() {
//        let formatter1 = DateFormatter()
//        formatter1.dateStyle = .full
//        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
//        if let timeUnitAmount = yearsView.timeUnitAmount.text {
//            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
//                updatedDate = updatedDate?.adding(.year, value: timeUnitAmountAsInt)
//            }
//        }
//        if let updatedDate = updatedDate {
//            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
//            self.updatedDate = updatedDate
//        }
//    }
//
//    private func updateDateAfterTurningSwitchOff() {
//        if updatedDate == nil {
//            updatedDate = datePicker.date
//        }
//        let formatter1 = DateFormatter()
//        formatter1.dateStyle = .full
//        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
//        if let updatedDate = updatedDate {
//            if weeksView.timeUnitAmount.text == "0" && monthsView.timeUnitAmount.text == "0" && yearsView.timeUnitAmount.text == "0" {
//                endDateLabel.text = Strings.productCoveredUntil
//            } else {
//                endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
//            }
//        }
//    }
//}
//
//extension NewWarrantyProductInfoViewController {
//
//    // MARK: - View configuration
//
//    private func setupView() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(aboutToCloseAlert))
//
//        screenTitle.text = Strings.screenTitle
//        screenTitle.font = MWFont.modalMainTitle
//        screenTitle.textAlignment = .natural
//
//        nameField.autocorrectionType = .no
//        nameField.placeholder = Strings.productNamePlaceHolder
//        nameField.setBottomBorder()
//        nameField.addDoneToolbar()
//        nameField.addTarget(self, action: #selector(nameTextfieldDidChange), for: .editingChanged)
//        nameField.becomeFirstResponder()
//
//        nameStackView = UIStackView(arrangedSubviews: [screenTitle, nameField])
//        nameStackView.axis = .vertical
//        nameStackView.spacing = 20
//
//        startDateTitle.text = Strings.warrantyStartDate
//        startDateTitle.font = MWFont.modalSubtitles
//        startDateTitle.textAlignment = .natural
//
//        datePicker.datePickerMode = .date
//        datePicker.addTarget(self, action: #selector(updateTimeIntervals), for: .editingDidEnd)
//
//        startDateStackView.axis = .vertical
//        startDateStackView.alignment = .leading
//        startDateStackView.spacing = 12
//        startDateStackView.addArrangedSubview(startDateTitle)
//        startDateStackView.addArrangedSubview(datePicker)
//
//        nameAndStartDateStackView.axis = .vertical
//        nameAndStartDateStackView.spacing = 40
//        nameAndStartDateStackView.addArrangedSubview(nameStackView)
//        nameAndStartDateStackView.addArrangedSubview(startDateStackView)
//
//        notificationTitle.text = "Rappel"
//        notificationTitle.font = MWFont.modalSubtitles
//        notificationSwitch.addTarget(self, action: #selector(notificationSwitchAction), for: .valueChanged)
//
//        notificationStackView.axis = .horizontal
//        notificationStackView.addArrangedSubview(notificationTitle)
//        notificationStackView.addArrangedSubview(notificationSwitch)
//
//        validityLengthTitle.text = Strings.validityLength
//        validityLengthTitle.font = MWFont.modalSubtitles
//
//        lifetimeWarrantyTitle.text = Strings.lifetimeWarranty
//        lifetimeWarrantySwitch.addTarget(self, action: #selector(lifetimeSwitchAction), for: .valueChanged)
//
//        lifetimeWarrantyStackView.axis = .horizontal
//        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantyTitle)
//        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantySwitch)
//
//        monthsView.setup()
//        weeksView.setup()
//        yearsView.setup()
//
//        yearsView.timeUnitTitle.text = Strings.years
//        yearsView.stepper.addTarget(self, action: #selector(yearsStepperTapped), for: .valueChanged)
//
//        monthsView.timeUnitTitle.text = Strings.months
//        monthsView.stepper.addTarget(self, action: #selector(monthsStepperTapped), for: .valueChanged)
//
//        weeksView.timeUnitTitle.text = Strings.weeks
//        weeksView.stepper.addTarget(self, action: #selector(weeksStepperTapped), for: .valueChanged)
//
//        customLengthStackView.axis = .vertical
//        customLengthStackView.spacing = 16
//        customLengthStackView.addArrangedSubview(validityLengthTitle)
//        customLengthStackView.addArrangedSubview(lifetimeWarrantyStackView)
//        customLengthStackView.addArrangedSubview(yearsView)
//        customLengthStackView.addArrangedSubview(monthsView)
//        customLengthStackView.addArrangedSubview(weeksView)
//        customLengthStackView.addArrangedSubview(notificationStackView)
//        customLengthStackView.setCustomSpacing(40, after: weeksView)
//
//        endDateLabel.textAlignment = .center
//        endDateLabel.text = Strings.productCoveredUntil
//        endDateLabel.numberOfLines = 2
//
//        parentStackView.translatesAutoresizingMaskIntoConstraints = false
//        parentStackView.axis = .vertical
//        parentStackView.spacing = 40
//        parentStackView.addArrangedSubview(nameAndStartDateStackView)
//        parentStackView.addArrangedSubview(customLengthStackView)
//        parentStackView.addArrangedSubview(endDateLabel)
//
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(parentStackView)
//
//        endCurrentScreenButton.setup(title: Strings.nextStepButtonTitle)
//        endCurrentScreenButton.addTarget(self, action: #selector(goToAddProductPhotoScreen), for: .touchUpInside)
//
//        view.backgroundColor = MWColor.background
//        view.addSubview(scrollView)
//        view.addSubview(endCurrentScreenButton)
//
//        NSLayoutConstraint.activate([
//            endDateLabel.heightAnchor.constraint(equalToConstant: 60),
//
//            parentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
//            parentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
//            parentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
//            parentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
//
//            scrollView.heightAnchor.constraint(equalTo: parentStackView.heightAnchor),
//            scrollView.widthAnchor.constraint(equalTo: parentStackView.widthAnchor, constant: 4),
//
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
//            scrollView.bottomAnchor.constraint(lessThanOrEqualTo: endCurrentScreenButton.topAnchor, constant: -16),
//
//            endCurrentScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            endCurrentScreenButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
//            endCurrentScreenButton.heightAnchor.constraint(equalToConstant: 55),
//            endCurrentScreenButton.widthAnchor.constraint(equalToConstant: 170)
//        ])
//    }
//}
