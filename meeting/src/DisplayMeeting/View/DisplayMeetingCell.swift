//
//  DisplayMeetingCell.swift
//  meeting
//
//  Created by Denis Burdin on 19.09.2022.
//

import UIKit

final class DisplayMeetingCell: UITableViewCell {
    static let identifier = String(describing: self)
    private let labelInfo = UILabel().prepareForAutoLayout()
    private enum Constants {
        static let defaultFontSize: CGFloat = 18.0
        static let cellTopMargin: CGFloat = 10.0
        static let cellLeftMargin: CGFloat = 20.0
        static let cellBottomMargin: CGFloat = 10.0
        static let cellRightMargin: CGFloat = 10.0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        configureSubviews()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View configuration
    private func configureSubviews() {
        contentView.prepareForAutoLayout()
        contentView.pinEdgesToSuperviewEdges()
        contentView.addSubview(labelInfo)
        labelInfo.numberOfLines = 0
        labelInfo.font = .systemFont(ofSize: Constants.defaultFontSize)
        labelInfo.pinEdgesToSuperviewEdges(
            top: Constants.cellTopMargin,
            left: Constants.cellLeftMargin,
            bottom: Constants.cellBottomMargin,
            right: Constants.cellRightMargin
        )
    }

    func apply(viewModel: DisplayMeeting.MeetingCell.ViewModel) {
        let width: CGFloat = contentView.bounds.size.width
        let estimatedHeight: CGFloat = viewModel.info.height(
            withConstrainedWidth: width - (Constants.cellLeftMargin + Constants.cellRightMargin),
            font: .systemFont(ofSize: Constants.defaultFontSize)
        )
        labelInfo.heightAnchor ~= estimatedHeight + Constants.cellTopMargin + Constants.cellBottomMargin
        labelInfo.text = viewModel.info
    }
}
