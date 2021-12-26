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
    var ParseInventoryControlNumber: String?
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

    var rawDataLines: [Substring]
    var rowCount: Int
    var parseMaster: [String: (String) -> Void] = [:]

    init(rawString: String) {
        rawDataLines = rawString.split(separator: "\n")
        rowCount = rawDataLines.count

        registerParsers()

        print(rawString)
        print("\(rowCount) lines")
    }

    func registerParsers() {
        parseMaster["DCA"] = parseVehicleClass
        parseMaster["DCB"] = parseRestrictions
        parseMaster["DCD"] = parseEndorsements
        parseMaster["DBA"] = parseExpirationDate  // MMDDCCYY or CCYYMMDD
        parseMaster["DCS"] = parseFamilyName
        parseMaster["DAC"] = parseFirstName
        parseMaster["DAD"] = parseMiddleNames // comma sep
        parseMaster["DBD"] = parseDocumentIssueDate // MMDDCCYY or CCYYMMDD
        parseMaster["DBB"] = parseDateOfBirth // MMDDCCYY or CCYYMMDD
        parseMaster["DBC"] = parseGender
        parseMaster["DAY"] = parseEyeColor
        parseMaster["DAU"] = parseHeight // nnn in or cm
        parseMaster["DAG"] = parseAddressStreet
        parseMaster["DAI"] = parseAddressCity
        parseMaster["DAJ"] = parseAddressJurisdictionCode
        parseMaster["DAK"] = parseAddressPostalCode
        parseMaster["DAQ"] = parseCustomerIDNumber
        parseMaster["DCF"] = parseDocumentDiscriminator
        parseMaster["DCG"] = parseCountryId
        parseMaster["DDE"] = parseFamilyNameTruncationFlag  // T/N/U
        parseMaster["DDF"] = parseFirstNameTruncationFlag   // T/N/U
        parseMaster["DDG"] = parseMiddleNameTruncationFlag  // T/N/U

        parseMaster["DAH"] = parseAddressStreet2
        parseMaster["DAZ"] = parseHairColor
        parseMaster["DCI"] = parsePlaceOfBirth
        parseMaster["DCJ"] = parseAuditInformation
        parseMaster["DCK"] = parseParseInventoryControlNumber
        parseMaster["DBN"] = parseAKAFamilyName
        parseMaster["DBG"] = parseAKAFirstName
        parseMaster["DBS"] = parseAKASuffixName
        parseMaster["DCU"] = parseNameSuffix
        parseMaster["DCE"] = parseWeightRange
        parseMaster["DCL"] = parseRaceEthniciy
        parseMaster["DCM"] = parseStandardVehicleClassification
        parseMaster["DCN"] = parseStandardEndorsementCode
        parseMaster["DCO"] = parseStandardRestrictionCode
        parseMaster["DCP"] = parseJurisdictionSpecificVehicleClassificationDescription
        parseMaster["DCQ"] = parseJurisdictionSpecificEndorsementCodeDescription
        parseMaster["DCR"] = parseJurisdictionSpecificRestrictionCodeDescription
        parseMaster["DDA"] = parseComplianceType
        parseMaster["DDB"] = parseCardRevisionDate // MMDDCCYY or CCYYMMDD
        parseMaster["DDC"] = parseHAZMATEndorsementExpirationDate // MMDDCCYY or CCYYMMDD
        parseMaster["DDD"] = parseLimitedDurationDocumentIndicator
        parseMaster["DAW"] = parseWeightPounds
        parseMaster["DAX"] = parseWeightKilograms
        parseMaster["DDH"] = parseUnder18UntilDate // MMDDCCYY or CCYYMMDD
        parseMaster["DDI"] = parseUnder19UntilDate // MMDDCCYY or CCYYMMDD
        parseMaster["DDJ"] = parseUnder21UntilDate // MMDDCCYY or CCYYMMDD
        parseMaster["DDK"] = parseOrganDonorIndicator // 1
        parseMaster["DDL"] = parseVeteranIndicator // 1
    }

    func parseDL() {
        for rawDataLine in rawDataLines {
            if checkForCodeLine(String(rawDataLine)) {
                parseDL(rawDataLine)
            }
        }
    }

    private func checkForCodeLine(_ rawDataLine: String) -> Bool {
        if rawDataLine.count < 4 {
            print("raw data line count < 4")
            return false
        }

        let charSeq1 = rawDataLine.prefix(1)
        let char1 = String(charSeq1)
        return char1 == "D"
    }

    private func parseDL(_ rawDataLine: Substring) {
        let rawDataLineString: String = String(rawDataLine)
        let codeStart = rawDataLineString.startIndex
        let codeEnd = rawDataLineString.index(rawDataLineString.startIndex, offsetBy: 2)
        let code = rawDataLineString[codeStart...codeEnd]
        let codeString = String(code)

        let valueStart = rawDataLineString.index(rawDataLineString.startIndex, offsetBy: 3)
        let valueEnd = rawDataLineString.endIndex
        let value = rawDataLineString[valueStart..<valueEnd]
        let valueString = String(value)

        let parser = parseMaster[codeString]
        if parser != nil {
            parser! (String(value))
        } else {
            print("no parser for \(codeString) to interpret \(valueString)")
        }
    }

    private func parseDateString(dataLine: String) -> Date {
        let result = Date()
        return result
    }

    private func parseTruncationFlag(dataLine: String) -> TruncateFlag {
        let result: TruncateFlag = .NotTruncated
        return result
    }

    private func parseVehicleClass(dataLine: String) {
        self.vehicleClass = dataLine
    }

    private func parseRestrictions(dataLine: String) {
        self.restrictions = dataLine
    }

    private func parseEndorsements(dataLine: String) {
        self.endorsements = dataLine
    }

    private func parseExpirationDate(dataLine: String) {
        self.expirationDate = parseDateString(dataLine: dataLine)
        // MMDDCCYY or CCYYMMDD
    }

    private func parseFamilyName(dataLine: String) {
        self.familyName = dataLine
    }

    private func parseFirstName(dataLine: String) {
        self.firstName = dataLine
    }

    private func parseMiddleNames(dataLine: String) {
        // comma sep
        self.middleNames = dataLine
    }

    private func parseDocumentIssueDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        self.DocumentIssueDate = parseDateString(dataLine: dataLine)
    }

    private func parseDateOfBirth(dataLine: String) {
        self.DateOfBirth = parseDateString(dataLine: dataLine)
        // MMDDCCYY or CCYYMMDD
    }

    private func parseGender(dataLine: String) {
        self.DateOfBirth = parseDateString(dataLine: dataLine)
    }

    private func parseEyeColor(dataLine: String) {
        self.EyeColor = dataLine
    }

    private func parseHeight(dataLine: String) {
        self.Height = dataLine
        // nnn in or cm
    }

    private func parseAddressStreet(dataLine: String) {
        self.AddressStreet = dataLine
    }

    private func parseAddressCity(dataLine: String) {
        self.AddressCity = dataLine
    }

    private func parseAddressJurisdictionCode(dataLine: String) {
        self.AddressJurisdictionCode = dataLine
    }

    private func parseAddressPostalCode(dataLine: String) {
        self.AddressPostalCode = dataLine
    }

    private func parseCustomerIDNumber(dataLine: String) {
        self.CustomerIDNumber = dataLine
    }

    private func parseDocumentDiscriminator(dataLine: String) {
        self.DocumentDiscriminator = dataLine
    }

    private func parseCountryId(dataLine: String) {
        self.countryId = dataLine
    }

    private func parseFamilyNameTruncationFlag(dataLine: String) {
        // T/N/U
        self.FamilyNameTruncationFlag = parseTruncationFlag(dataLine: dataLine)
    }

    private func parseFirstNameTruncationFlag(dataLine: String) {
        // T/N/U
        self.FirstNameTruncationFlag = parseTruncationFlag(dataLine: dataLine)
    }

    private func parseMiddleNameTruncationFlag(dataLine: String) {
        // T/N/U
        self.FirstNameTruncationFlag = parseTruncationFlag(dataLine: dataLine)
    }

    private func parseAddressStreet2(dataLine: String) {
        self.AddressStreet2 = dataLine
    }

    private func parseHairColor(dataLine: String) {
        self.HairColor = dataLine
    }

    private func parsePlaceOfBirth(dataLine: String) {
        self.PlaceOfBirth = dataLine
    }

    private func parseAuditInformation(dataLine: String) {
        self.AuditInformation = dataLine
    }

    private func parseParseInventoryControlNumber(dataLine: String) {
        self.ParseInventoryControlNumber = dataLine
    }

    private func parseAKAFamilyName(dataLine: String) {
        self.AKAFamilyName = dataLine
    }

    private func parseAKAFirstName(dataLine: String) {
        self.AKAFamilyName = dataLine
    }

    private func parseAKASuffixName(dataLine: String) {
        self.AKASuffixName = dataLine
    }

    private func parseNameSuffix(dataLine: String) {
        self.NameSuffix = dataLine
    }

    private func parseWeightRange(dataLine: String) {
        self.WeightRange = dataLine
    }

    private func parseRaceEthniciy(dataLine: String) {
        self.RaceEthniciy = dataLine
    }

    private func parseStandardVehicleClassification(dataLine: String) {
        self.StandardVehicleClassification = dataLine
    }

    private func parseStandardEndorsementCode(dataLine: String) {
        self.StandardEndorsementCode = dataLine
    }

    private func parseStandardRestrictionCode(dataLine: String) {
        self.StandardRestrictionCode = dataLine
    }

    private func parseJurisdictionSpecificVehicleClassificationDescription(dataLine: String) {
        self.JurisdictionSpecificVehicleClassificationDescription = dataLine
    }

    private func parseJurisdictionSpecificEndorsementCodeDescription(dataLine: String) {
        self.JurisdictionSpecificEndorsementCodeDescription = dataLine
    }

    private func parseJurisdictionSpecificRestrictionCodeDescription(dataLine: String) {
        self.JurisdictionSpecificRestrictionCodeDescription = dataLine
    }

    private func parseComplianceType(dataLine: String) {
        self.ComplianceType = dataLine
    }

    private func parseCardRevisionDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        self.CardRevisionDate = parseDateString(dataLine: dataLine)
    }

    private func parseHAZMATEndorsementExpirationDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        self.HAZMATEndorsementExpirationDate = parseDateString(dataLine: dataLine)
    }

    private func parseLimitedDurationDocumentIndicator(dataLine: String) {
        self.LimitedDurationDocumentIndicator = dataLine
    }

    private func parseWeightPounds(dataLine: String) {
        self.WeightPounds = Int(dataLine)
    }

    private func parseWeightKilograms(dataLine: String) {
        self.WeightKilograms = Int(dataLine)
    }

    private func parseUnder18UntilDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        self.Under18UntilDate = parseDateString(dataLine: dataLine)
    }

    private func parseUnder19UntilDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        self.Under19UntilDate = parseDateString(dataLine: dataLine)
    }

    private func parseUnder21UntilDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        self.Under21UntilDate = parseDateString(dataLine: dataLine)
    }

    private func parseOrganDonorIndicator(dataLine: String) {
        // 1
        self.OrganDonorIndicator = dataLine == "1"
    }

    private func parseVeteranIndicator(dataLine: String) {
        // 1
        self.VeteranIndicator = dataLine == "1"
    }
}
