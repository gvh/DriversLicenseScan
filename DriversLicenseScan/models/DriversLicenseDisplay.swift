//
//  DriversLicenseDisplay.swift
//  DriversLicenseScan
//
//  Created by Gardner von Holt on 12/26/21.
//

import Foundation

class DriversLicenseDisplay {
    let driversLicense: DriversLicense
    var items: [LicenseItem] = []
    
    init(_ driversLicense: DriversLicense) {
        self.driversLicense = driversLicense

        addNameDisplay()
        addCodesDisplay()
        addDatesDisplay()
        addOtherDatesDisplay()
        addAddressDisplay()

        addPlaceOfBirth()
        addBiologicDisplay()
        addIdsDisplay()
        addLegalDateDisplay()
        addIndicatorsDisplay()
    }

    private func addItem(label: String, value: String ) {
        let newSequence = items.count
        let driversLicenseItem = LicenseItem(sequence: newSequence, label: label, value: value)
        items.append(driversLicenseItem)
    }

    func addNameDisplay() {
        var firstName: String = driversLicense.firstName?.localizedTitleCasedString(linguistic: false) ?? ""
        if driversLicense.FirstNameTruncationFlag != nil && driversLicense.FirstNameTruncationFlag! == .Truncated {
            firstName += "..."
        }
        if driversLicense.AKAFirstName != nil && driversLicense.AKAFirstName! != "" {
            firstName += "(" + driversLicense.AKAFirstName!.localizedTitleCasedString(linguistic: false) + ")"
        }

        var middleName: String = driversLicense.middleNames?.localizedTitleCasedString(linguistic: false) ?? ""
        if driversLicense.MiddleNameTruncationFlag != nil && driversLicense.MiddleNameTruncationFlag! == .Truncated {
            middleName += "..."
        }

        var familyName: String = driversLicense.familyName?.localizedTitleCasedString(linguistic: false) ?? ""
        if driversLicense.FamilyNameTruncationFlag != nil && driversLicense.FamilyNameTruncationFlag! == .Truncated {
            familyName += "..."
        }
        if driversLicense.AKAFamilyName != nil && driversLicense.AKAFamilyName! != "" {
            familyName += "(" + driversLicense.AKAFamilyName!.localizedTitleCasedString(linguistic: false) + ")"
        }

        var suffixName: String = ""
        if driversLicense.NameSuffix != nil && driversLicense.NameSuffix! != "" {
            suffixName += driversLicense.NameSuffix!.localizedTitleCasedString(linguistic: false)
        }
        if driversLicense.AKASuffixName != nil && driversLicense.AKASuffixName! != "" {
            suffixName += "(" + driversLicense.AKASuffixName!.localizedTitleCasedString(linguistic: false) + ")"
        }

        firstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        middleName = middleName.trimmingCharacters(in: .whitespacesAndNewlines)
        familyName = familyName.trimmingCharacters(in: .whitespacesAndNewlines)
        suffixName = suffixName.trimmingCharacters(in: .whitespacesAndNewlines)
        var name = firstName
        if middleName != "" {
            name = name + " " + middleName
        }
        if familyName != "" {
            name = name + " " + familyName
        }
        if suffixName != "" {
            name = name + ", " + suffixName
        }
        name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        addItem(label: name, value: "")
    }

    func addCodesDisplay() {
        let vehicleClassDisplay = (driversLicense.vehicleClass ?? driversLicense.JurisdictionSpecificVehicleClassificationDescription) ?? ""
        if vehicleClassDisplay != "" {
            addItem(label: "vehicle class", value: vehicleClassDisplay)
        }

        let restrictionsDisplay = (driversLicense.restrictions ?? driversLicense.JurisdictionSpecificRestrictionCodeDescription) ?? ""
        if restrictionsDisplay != "" {
            addItem(label: "restrictions", value: restrictionsDisplay)
        }

        let endorsementsDisplay = (driversLicense.endorsements ?? driversLicense.JurisdictionSpecificEndorsementCodeDescription) ?? ""
        if endorsementsDisplay != "" {
            addItem(label: "endorsement", value: endorsementsDisplay)
        }

    }

    func addDatesDisplay() {
        let expirationDateDisplay = driversLicense.expirationDate?.ymdString() ?? ""
        if expirationDateDisplay != "" {
            addItem(label: "expiration date", value: expirationDateDisplay)
        }

        let documentIssueDateDisplay = driversLicense.DocumentIssueDate?.ymdString() ?? "" // MMDDCCYY or CCYYMMDD
        if documentIssueDateDisplay != "" {
            addItem(label: "doucment issued", value: documentIssueDateDisplay)
        }

        let dateOfBirthDisplay = driversLicense.DateOfBirth?.ymdString() ?? "" // MMDDCCYY or CCYYMMDD
        if dateOfBirthDisplay != "" {
            addItem(label: "date of birth", value: dateOfBirthDisplay)
        }
    }

    func addOtherDatesDisplay() {
        let cardRevisionDateDisplay = driversLicense.CardRevisionDate?.ymdString() ?? "" // MMDDCCYY or CCYYMMDD
        if cardRevisionDateDisplay != "" {
            addItem(label: "card revision date", value: cardRevisionDateDisplay)
        }

        let HAZMATEndorsementExpirationDateDisplay = driversLicense.HAZMATEndorsementExpirationDate?.ymdString() ?? "" // MMDDCCYY or CCYYMMDD
        if HAZMATEndorsementExpirationDateDisplay != "" {
            addItem(label: "HAZMAT endorse expiration date", value: HAZMATEndorsementExpirationDateDisplay)
        }
    }

    func addAddressDisplay() {
        var addressDisplay: String = ""
        addressDisplay += driversLicense.AddressStreet!
        if driversLicense.AddressStreet2 != nil && driversLicense.AddressStreet2 != "" {
            addressDisplay += ", " + driversLicense.AddressStreet2!
        }
        if driversLicense.AddressCity != nil && driversLicense.AddressCity != "" {
            addressDisplay += ", " + driversLicense.AddressCity!
        }
        if driversLicense.AddressJurisdictionCode != nil && driversLicense.AddressJurisdictionCode != "" {
            addressDisplay += ", " + driversLicense.AddressJurisdictionCode!
        }
        if driversLicense.AddressPostalCode != nil && driversLicense.AddressPostalCode != "" {
            addressDisplay += " " + driversLicense.AddressPostalCode!
        }
        if driversLicense.countryId != nil && driversLicense.countryId != "" {
            addressDisplay += " " + driversLicense.countryId!
        }
        addItem(label: "Address", value: addressDisplay)
    }

    func addPlaceOfBirth() {
        let placeOfBirthFieldDisplay = driversLicense.PlaceOfBirth ?? ""
        if placeOfBirthFieldDisplay != nil && placeOfBirthFieldDisplay != "" {
            addItem(label: "place of birth", value: placeOfBirthFieldDisplay)
        }
    }

    func addBiologicDisplay() {
        let genderDisplay: String = (driversLicense.Gender != nil && driversLicense.Gender != "") ? driversLicense.Gender! : ""
        if genderDisplay != "" {
            addItem(label: "gender", value: genderDisplay)
        }
        let raceDisplay: String = driversLicense.RaceEthniciy ?? ""
        if raceDisplay != "" {
            addItem(label: "race", value: raceDisplay)
        }
        let eyeColorDisplay: String = driversLicense.EyeColor ?? ""
        if eyeColorDisplay != "" {
            addItem(label: "eye color", value: eyeColorDisplay)
        }

        let hairColorDisplay: String = (driversLicense.HairColor != nil && driversLicense.HairColor != "") ? driversLicense.HairColor! : ""
        if hairColorDisplay != "" {
            addItem(label: "hair color", value: hairColorDisplay)
        }

        let heightDisplay: String = (driversLicense.Height != nil && driversLicense.Height != "") ? driversLicense.Height! : ""
        if heightDisplay != "" {
            addItem(label: "height", value: heightDisplay)
        }

        let weightDisplay: String = driversLicense.WeightPounds != nil ? String(driversLicense.WeightPounds!) + " lbs" :
                                    driversLicense.WeightKilograms != nil ? String(driversLicense.WeightKilograms!) + " kgs" :
                                    driversLicense.WeightRange != nil ? driversLicense.WeightRange! :  ""
        if weightDisplay != "" {
            addItem(label: "weight", value: weightDisplay)
        }

    }

    func addIdsDisplay() {
        let customerIdDisplay = driversLicense.CustomerIDNumber ?? ""
        if customerIdDisplay != "" {
            addItem(label: "customer id", value: customerIdDisplay)
        }

        let documentDiscriminatorDisplay = driversLicense.DocumentDiscriminator ?? ""
        if documentDiscriminatorDisplay != "" {
            addItem(label: "document discriminator", value: documentDiscriminatorDisplay)
        }

        let inventoryControlDisplay = driversLicense.InventoryControlNumber ?? ""
        if inventoryControlDisplay != "" {
            addItem(label: "inventory control", value: inventoryControlDisplay)
        }

        let complianceDisplay = driversLicense.ComplianceType ?? ""
        if complianceDisplay != "" {
            addItem(label: "compliance", value: complianceDisplay)
        }

        let auditInformationDisplay = driversLicense.AuditInformation ?? ""
        if auditInformationDisplay != "" {
            addItem(label: "audit information", value: auditInformationDisplay)
        }

    }

    func addLegalDateDisplay() {
        var legalDateDisplay: String = ""
        var legalDate: String = ""
        if driversLicense.Under18UntilDate != nil {
            legalDate = (driversLicense.Under18UntilDate!.ymdString())
            legalDateDisplay = "18 years on \(legalDate)"
        } else if driversLicense.Under19UntilDate != nil {
            legalDate = driversLicense.Under19UntilDate!.ymdString()
            legalDateDisplay = "19 years on \(legalDate)"
        } else if driversLicense.Under21UntilDate != nil {
            legalDate = driversLicense.Under21UntilDate!.ymdString()
            legalDateDisplay = "21 years on \(legalDate)"
        } else {
            legalDateDisplay = "no legal date info"
        }
        addItem(label: "legal date", value: legalDateDisplay)
    }

    func addIndicatorsDisplay() {
        let limitedDurationDocumentIndicatorDisplay: String = driversLicense.LimitedDurationDocumentIndicator == "1" ? "True" : "False"
        if limitedDurationDocumentIndicatorDisplay != "" {
            addItem(label: "limited duration", value: limitedDurationDocumentIndicatorDisplay)
        }

        let OrganDonorIndicatorDisplay = driversLicense.OrganDonorIndicator != nil && driversLicense.OrganDonorIndicator! == true ? "True" : "False" // 1
        if OrganDonorIndicatorDisplay != "" {
            addItem(label: "organ donor", value: OrganDonorIndicatorDisplay)
        }

        let VeteranIndicatorDisplay = driversLicense.VeteranIndicator != nil && driversLicense.VeteranIndicator! == true ? "True" : "False" // 1
        if VeteranIndicatorDisplay != "" {
            addItem(label: "veteran", value: VeteranIndicatorDisplay)
        }
    }
}
