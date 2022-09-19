//
//  Utils.swift
//  meeting
//
//  Created by Denis Burdin on 19.09.2022.
//

import Foundation
import UIKit

extension Collection {
    public subscript (safe index: Self.Index) -> Iterator.Element? {
        (startIndex ..< endIndex).contains(index) ? self[index] : nil
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.width)
    }

    /// Localize string key
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    /// Localize plural string key
    func localized<T>(_ count: T) -> String {
        // swiftlint:disable force_cast
        return String.localizedStringWithFormat(localized(), count as! CVarArg)
        // swiftlint:enable force_cast
    }

    /// Localize format string key
    func localized(arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
}
