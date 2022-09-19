//
//  DisplayMeetingViewController.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit

final class DisplayMeetingViewController: ViewController,
                                          DisplayMeetingDisplayLogic,
                                          UITableViewDataSource {
    private let interactor: DisplayMeetingBusinessLogic
    private let router: DisplayMeetingRoutingLogic
    private let tableView = UITableView().prepareForAutoLayout()
    private var events: [String] = [String]()

    init(interactor: DisplayMeetingBusinessLogic, router: DisplayMeetingRoutingLogic) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshEvents()
    }
    
    // MARK: - DisplayMeetingDisplayLogic
    
    func displayInitForm(_ viewModel: DisplayMeeting.InitForm.ViewModel) {
        if events.count > 1,
           viewModel.eventInfo.count != events.count {
            scrollToBottom()
        }
        events.removeAll()
        events += viewModel.eventInfo
        tableView.reloadData()
    }
    
    // MARK: - Private
    
    private func initForm() {
        interactor.requestInitForm(DisplayMeeting.InitForm.Request())
    }
    
    private func refreshEvents() {
        interactor.requestEvents(DisplayMeeting.InitForm.Request())
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let indexPath = IndexPath(row: self.events.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    private func configureUI() {
        view.addSubview(tableView)
        tableView.pinEdgesToSuperviewEdges()
        tableView.dataSource = self
        tableView.register(
            DisplayMeetingCell.self,
            forCellReuseIdentifier: DisplayMeetingCell.identifier
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DisplayMeetingCell.identifier,
            for: indexPath
        ) as? DisplayMeetingCell else {
            return UITableViewCell()
        }

        let event: String = events[safe: indexPath.row] ?? "no_events".localized
        let viewModel = DisplayMeeting.MeetingCell.ViewModel(
            info: event
        )
        cell.apply(viewModel: viewModel)
        
        return cell
    }
}
