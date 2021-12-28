//
//  DriversLicense.swift
//  DriversLicenseScan
//
//  Created by Gardner von Holt on 12/26/21.
//

import Foundation

enum TruncateFlag: String {
    case Truncated = "T"
    case NotTruncated = "N"
    case Unknown = "U"
}

class DriversLicense {
    var vehicleClass: String?
    var restrictions: String?
    var endorsements: String?

    var expirationDate: Date?  // MMDDCCYY or CCYYMMDD
    var familyName: String?
    var firstName: String?
    var middleNames: String? // comma sep

    var DocumentIssueDate: Date? // MMDDCCYY or CCYYMMDD
    var DateOfBirth: Date? // MMDDCCYY or CCYYMMDD
    var Gender: String?
    var EyeColor: String?
    var Height: String? // nnn in or cm
    var AddressStreet: String?
    var AddressCity: String?
    var AddressJurisdictionCode: String?
    var AddressPostalCode: String?
    var CustomerIDNumber: String?
    var DocumentDiscriminator: String?
    var countryId: String?
    var FamilyNameTruncationFlag: TruncateFlag?  // T/N/U
    var FirstNameTruncationFlag: TruncateFlag?  // T/N/U
    var MiddleNameTruncationFlag: TruncateFlag?  // T/N/U

    var AddressStreet2: String?
    var HairColor: String?
    var PlaceOfBirth: String?
    var AuditInformation: String?
    var InventoryControlNumber: String?
    var AKAFamilyName: String?
    var AKAFirstName: String?
    var AKASuffixName: String?
    var NameSuffix: String?
    var WeightRange: String?
    var RaceEthniciy: String?
    var StandardVehicleClassification: String?
    var StandardEndorsementCode: String?
    var StandardRestrictionCode: String?
    var JurisdictionSpecificVehicleClassificationDescription: String?
    var JurisdictionSpecificEndorsementCodeDescription: String?
    var JurisdictionSpecificRestrictionCodeDescription: String?
    var ComplianceType: String?
    var CardRevisionDate: Date? // MMDDCCYY or CCYYMMDD
    var HAZMATEndorsementExpirationDate: Date? // MMDDCCYY or CCYYMMDD
    var LimitedDurationDocumentIndicator: String?
    var WeightPounds: Int?
    var WeightKilograms: Int?
    var Under18UntilDate: Date? // MMDDCCYY or CCYYMMDD
    var Under19UntilDate: Date? // MMDDCCYY or CCYYMMDD
    var Under21UntilDate: Date? // MMDDCCYY or CCYYMMDD
    var OrganDonorIndicator: Bool? // 1
    var VeteranIndicator: Bool? // 1

    init() {
        
    }

}
