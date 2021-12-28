//
//  LicenseItem.swift
//  DriversLicenseScan
//
//  Created by Gardner von Holt on 12/27/21.
//

import Foundation

class LicenseItem {
    var sequence: Int
    var label: String
    var value: String

    init(sequence: Int, label: String, value: String) {
        self.sequence = sequence
        self.label = label
        self.value = value
    }
}

extension LicenseItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(value)
    }
}

extension LicenseItem: Equatable {
    static func == (lhs: LicenseItem, rhs: LicenseItem) -> Bool {
        return
            lhs.label == rhs.label &&
            lhs.value == rhs.value
    }

}

extension LicenseItem: Identifiable {
}
