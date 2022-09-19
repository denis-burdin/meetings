//
//  InputMeetingViewController.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit

final class InputMeetingViewController: ViewController, InputMeetingDisplayLogic {
    private enum Constants {
        static let leftInset: CGFloat = 20.0
        static let rightInset: CGFloat = 20.0
        static let bottomInset: CGFloat = 20.0
        static let marginInterval: CGFloat = 30.0
        static let cornerRadius: CGFloat = 10.0
        static let shortMarginInterval: CGFloat = 10.0
        static let descriptionHeight: CGFloat = 100.0
        static let defaultFontSize: CGFloat = 20.0
        static let defaultButtonHeight: CGFloat = 50.0
        static let horizontalBottomAnchor: CGFloat = 50.0
    }
    private let interactor: InputMeetingBusinessLogic
    private let router: InputMeetingRoutingLogic
    private let labelName = UILabel().prepareForAutoLayout()
    private let inputName = UITextField().prepareForAutoLayout()
    private let labelStartDate = UILabel().prepareForAutoLayout()
    private let inputStartDate = UIDatePicker().prepareForAutoLayout()
    private let labelEndDate = UILabel().prepareForAutoLayout()
    private let inputEndDate = UIDatePicker().prepareForAutoLayout()
    private let labelDescription = UILabel().prepareForAutoLayout()
    private let inputDescription = UITextView().prepareForAutoLayout()
    private let saveButton = UIButton().prepareForAutoLayout()
    
    init(interactor: InputMeetingBusinessLogic, router: InputMeetingRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        initForm()
    }
    
    // MARK: - InputMeetingDisplayLogic
    
    func displayInitForm(_ viewModel: InputMeeting.InitForm.ViewModel) {
        
    }
    
    // MARK: - Private
    
    private func initForm() {
        interactor.requestInitForm(InputMeeting.InitForm.Request())
    }
    
    private func configureUI() {
        view.addSubview(labelName)
        let safeArea = view.safeAreaLayoutGuide
        let leftInset = safeArea.leadingAnchor + Constants.leftInset
        let rightInset = safeArea.trailingAnchor - Constants.rightInset
        labelName.topAnchor ~= safeArea.topAnchor + Constants.marginInterval
        labelName.leadingAnchor ~= leftInset
        labelName.text = "event_name".localized
        
        view.addSubview(inputName)
        inputName.placeholder = "set_event_name".localized
        inputName.topAnchor ~= labelName.bottomAnchor + Constants.shortMarginInterval
        inputName.leadingAnchor ~= leftInset
        inputName.trailingAnchor ~= rightInset
        inputName.borderStyle = .roundedRect
        inputName.layer.cornerRadius = Constants.cornerRadius
        inputName.addTarget(
            self,
            action: #selector(inputNameDidChange),
            for: .editingChanged
        )
        
        view.addSubview(labelStartDate)
        labelStartDate.topAnchor ~= inputName.bottomAnchor + Constants.marginInterval
        labelStartDate.leadingAnchor ~= leftInset
        labelStartDate.text = "start_event".localized
        
        view.addSubview(inputStartDate)
        inputStartDate.centerYAnchor ~= labelStartDate.centerYAnchor
        inputStartDate.leadingAnchor ~= labelStartDate.trailingAnchor + Constants.shortMarginInterval
        
        view.addSubview(labelEndDate)
        labelEndDate.topAnchor ~= inputStartDate.bottomAnchor + Constants.marginInterval
        labelEndDate.leadingAnchor ~= leftInset
        labelEndDate.text = "end_event".localized
        
        view.addSubview(inputEndDate)
        inputEndDate.centerYAnchor ~= labelEndDate.centerYAnchor
        inputEndDate.leadingAnchor ~= inputStartDate.leadingAnchor
        inputEndDate.datePickerMode = .time
        
        view.addSubview(labelDescription)
        labelDescription.topAnchor ~= labelEndDate.bottomAnchor + Constants.marginInterval
        labelDescription.leadingAnchor ~= leftInset
        labelDescription.text = "description_title".localized
        
        view.addSubview(inputDescription)
        inputDescription.topAnchor ~= labelDescription.bottomAnchor + Constants.shortMarginInterval
        inputDescription.heightAnchor ~= Constants.descriptionHeight
        inputDescription.widthAnchor ~= inputName.widthAnchor
        inputDescription.leadingAnchor ~= leftInset
        inputDescription.trailingAnchor ~= rightInset
        inputDescription.isEditable = true
        inputDescription.isSelectable = true
        inputDescription.layer.cornerRadius = Constants.cornerRadius
        inputDescription.font = .systemFont(ofSize: Constants.defaultFontSize)
        
        view.addSubview(saveButton)
        saveButton.heightAnchor ~= Constants.defaultButtonHeight
        saveButton.bottomAnchor ~= safeArea.bottomAnchor - Constants.bottomInset
        saveButton.trailingAnchor ~= safeArea.trailingAnchor - Constants.horizontalBottomAnchor
        saveButton.leadingAnchor ~= safeArea.leadingAnchor + Constants.horizontalBottomAnchor
        saveButton.backgroundColor = .lightGray
        saveButton.setTitle("save_button".localized, for: .normal)
        saveButton.layer.cornerRadius = Constants.cornerRadius
        saveButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        if inputStartDate.date > inputEndDate.date {
            let alert = UIAlertController(
                title: "error_title".localized,
                message: "error_text".localized,
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(
                    title: "ok".localized,
                    style: .default,
                    handler: nil
                )
            )
            self.present(alert, animated: true, completion: nil)
        } else if inputStartDate.date == inputEndDate.date {
            let alert = UIAlertController(
                title: "warning_title".localized,
                message: "warning_text".localized,
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(
                    title: "ok_action_button".localized,
                    style: .default,
                    handler: nil
                )
            )
            self.present(alert, animated: true, completion: nil)
        } else {
            let event = Event(
                name: inputName.text ?? "",
                startDate: inputStartDate.date,
                endDate: inputEndDate.date,
                creationDate: Date(),
                info: inputDescription.text
            )
            interactor.saveRecord(event)
            emptyInput()
        }
    }
    
    private func emptyInput() {
        inputName.text = ""
        inputStartDate.date = Date()
        inputEndDate.date = Date()
        inputDescription.text = ""
        saveButton.isEnabled = false
        saveButton.backgroundColor = .lightGray
    }
    
    @objc private func inputNameDidChange() {
        if let text = inputName.text, text.count > 0 {
            saveButton.isEnabled = true
            saveButton.backgroundColor = .systemBlue
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .lightGray
        }
    }
}
