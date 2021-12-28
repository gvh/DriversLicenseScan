//
//  DriversLicenseParser.swift
//  DriversLicenseScan
//
//  Created by Gardner von Holt on 12/27/21.
//

import Foundation

class DriversLicenseParser {

    var driversLicense: DriversLicense = DriversLicense()
    var parseMaster: [String: (String) -> Void] = [:]

    init() {
        registerParsers()
    }

    private func registerParsers() {
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
        parseMaster["DCK"] = parseInventoryControlNumber
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

    func parse(rawString: String) -> DriversLicense {
        self.driversLicense = DriversLicense()
        var rawDataLines: [Substring] = rawString.split(separator: "\n")
        let rowCount = rawDataLines.count
        for rawDataLine in rawDataLines {
            if checkForCodeLine(String(rawDataLine)) {
                parseLine(rawDataLine)
            }
        }
        return driversLicense
    }

    private func parseLine(_ rawDataLine: Substring) {
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

    private func checkForCodeLine(_ rawDataLine: String) -> Bool {
        if rawDataLine.count < 4 {
            print("raw data line count < 4")
            return false
        }

        let charSeq1 = rawDataLine.prefix(1)
        let char1 = String(charSeq1)
        return char1 == "D"
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
        driversLicense.vehicleClass = dataLine
    }

    private func parseRestrictions(dataLine: String) {
        driversLicense.restrictions = dataLine
    }

    private func parseEndorsements(dataLine: String) {
        driversLicense.endorsements = dataLine
    }

    private func parseExpirationDate(dataLine: String) {
        driversLicense.expirationDate = parseDateString(dataLine: dataLine)
        // MMDDCCYY or CCYYMMDD
    }

    private func parseFamilyName(dataLine: String) {
        driversLicense.familyName = dataLine
    }

    private func parseFirstName(dataLine: String) {
        driversLicense.firstName = dataLine
    }

    private func parseMiddleNames(dataLine: String) {
        // comma sep
        driversLicense.middleNames = dataLine
    }

    private func parseDocumentIssueDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        driversLicense.DocumentIssueDate = parseDateString(dataLine: dataLine)
    }

    private func parseDateOfBirth(dataLine: String) {
        driversLicense.DateOfBirth = parseDateString(dataLine: dataLine)
        // MMDDCCYY or CCYYMMDD
    }

    private func parseGender(dataLine: String) {
        driversLicense.DateOfBirth = parseDateString(dataLine: dataLine)
    }

    private func parseEyeColor(dataLine: String) {
        driversLicense.EyeColor = dataLine
    }

    private func parseHeight(dataLine: String) {
        driversLicense.Height = dataLine
        // nnn in or cm
    }

    private func parseAddressStreet(dataLine: String) {
        driversLicense.AddressStreet = dataLine
    }

    private func parseAddressCity(dataLine: String) {
        driversLicense.AddressCity = dataLine
    }

    private func parseAddressJurisdictionCode(dataLine: String) {
        driversLicense.AddressJurisdictionCode = dataLine
    }

    private func parseAddressPostalCode(dataLine: String) {
        driversLicense.AddressPostalCode = dataLine
    }

    private func parseCustomerIDNumber(dataLine: String) {
        driversLicense.CustomerIDNumber = dataLine
    }

    private func parseDocumentDiscriminator(dataLine: String) {
        driversLicense.DocumentDiscriminator = dataLine
    }

    private func parseCountryId(dataLine: String) {
        driversLicense.countryId = dataLine
    }

    private func parseFamilyNameTruncationFlag(dataLine: String) {
        // T/N/U
        driversLicense.FamilyNameTruncationFlag = parseTruncationFlag(dataLine: dataLine)
    }

    private func parseFirstNameTruncationFlag(dataLine: String) {
        // T/N/U
        driversLicense.FirstNameTruncationFlag = parseTruncationFlag(dataLine: dataLine)
    }

    private func parseMiddleNameTruncationFlag(dataLine: String) {
        // T/N/U
        driversLicense.FirstNameTruncationFlag = parseTruncationFlag(dataLine: dataLine)
    }

    private func parseAddressStreet2(dataLine: String) {
        driversLicense.AddressStreet2 = dataLine
    }

    private func parseHairColor(dataLine: String) {
        driversLicense.HairColor = dataLine
    }

    private func parsePlaceOfBirth(dataLine: String) {
        driversLicense.PlaceOfBirth = dataLine
    }

    private func parseAuditInformation(dataLine: String) {
        driversLicense.AuditInformation = dataLine
    }

    private func parseInventoryControlNumber(dataLine: String) {
        driversLicense.InventoryControlNumber = dataLine
    }

    private func parseAKAFamilyName(dataLine: String) {
        driversLicense.AKAFamilyName = dataLine
    }

    private func parseAKAFirstName(dataLine: String) {
        driversLicense.AKAFamilyName = dataLine
    }

    private func parseAKASuffixName(dataLine: String) {
        driversLicense.AKASuffixName = dataLine
    }

    private func parseNameSuffix(dataLine: String) {
        driversLicense.NameSuffix = dataLine
    }

    private func parseWeightRange(dataLine: String) {
        driversLicense.WeightRange = dataLine
    }

    private func parseRaceEthniciy(dataLine: String) {
        driversLicense.RaceEthniciy = dataLine
    }

    private func parseStandardVehicleClassification(dataLine: String) {
        driversLicense.StandardVehicleClassification = dataLine
    }

    private func parseStandardEndorsementCode(dataLine: String) {
        driversLicense.StandardEndorsementCode = dataLine
    }

    private func parseStandardRestrictionCode(dataLine: String) {
        driversLicense.StandardRestrictionCode = dataLine
    }

    private func parseJurisdictionSpecificVehicleClassificationDescription(dataLine: String) {
        driversLicense.JurisdictionSpecificVehicleClassificationDescription = dataLine
    }

    private func parseJurisdictionSpecificEndorsementCodeDescription(dataLine: String) {
        driversLicense.JurisdictionSpecificEndorsementCodeDescription = dataLine
    }

    private func parseJurisdictionSpecificRestrictionCodeDescription(dataLine: String) {
        driversLicense.JurisdictionSpecificRestrictionCodeDescription = dataLine
    }

    private func parseComplianceType(dataLine: String) {
        driversLicense.ComplianceType = dataLine
    }

    private func parseCardRevisionDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        driversLicense.CardRevisionDate = parseDateString(dataLine: dataLine)
    }

    private func parseHAZMATEndorsementExpirationDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        driversLicense.HAZMATEndorsementExpirationDate = parseDateString(dataLine: dataLine)
    }

    private func parseLimitedDurationDocumentIndicator(dataLine: String) {
        driversLicense.LimitedDurationDocumentIndicator = dataLine
    }

    private func parseWeightPounds(dataLine: String) {
        driversLicense.WeightPounds = Int(dataLine)
    }

    private func parseWeightKilograms(dataLine: String) {
        driversLicense.WeightKilograms = Int(dataLine)
    }

    private func parseUnder18UntilDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        driversLicense.Under18UntilDate = parseDateString(dataLine: dataLine)
    }

    private func parseUnder19UntilDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        driversLicense.Under19UntilDate = parseDateString(dataLine: dataLine)
    }

    private func parseUnder21UntilDate(dataLine: String) {
        // MMDDCCYY or CCYYMMDD
        driversLicense.Under21UntilDate = parseDateString(dataLine: dataLine)
    }

    private func parseOrganDonorIndicator(dataLine: String) {
        // 1
        driversLicense.OrganDonorIndicator = dataLine == "1"
    }

    private func parseVeteranIndicator(dataLine: String) {
        // 1
        driversLicense.VeteranIndicator = dataLine == "1"
    }

}
