//
//  DateComponentsFormatterExtension.swift
//  KTV
//
//  Created by Chung Wussup on 3/11/24.
//

import Foundation

extension DateComponentsFormatter {

    static let playtimeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        
        return formatter
    }()
}
