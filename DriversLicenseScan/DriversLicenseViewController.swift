//
//  DriversLicenseViewController.swift
//  DriversLicenseScan
//
//  Created by Gardner von Holt on 12/26/21.
//

import UIKit

class DriversLicenseViewController: UIViewController {

    var driversLicense: DriversLicense!

    @IBOutlet weak var labelName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        var firstName: String = driversLicense.firstName ?? ""
        if driversLicense.FirstNameTruncationFlag != nil && driversLicense.FirstNameTruncationFlag == true {
            firstName += "..."
        }
        if driversLicense.AKAFirstName != nil && driversLicense.AKAFirstName != "" {
            firstName += "(" + driversLicense.AKAFirstName + ")"
        }

        var middleName: String = driversLicense.middleNames ?? ""
            if driversLicense.MiddleNameTruncationFlag != nil && driversLicense.MiddleNameTruncationFlag == true {
            middleName += "..."
        }

        var familyName: String = driversLicense.familyName ?? ""
        if driversLicense.FamilyNameTruncationFlag != nil && driversLicense.FamilyNameTruncationFlag == true {
            familyName += "..."
        }
        if driversLicense.AKAFamilyName != nil && driversLicense.AKAFamilyName != "" {
            familyName += "(" + driversLicense.AKAFamilyName + ")"
        }

        var suffixName: String = ""
        if driversLicense.NameSuffix != nil && driversLicense.NameSuffix != "" {
            suffixName += driversLicense.NameSuffix
        }
        if driversLicense.AKASuffixName != nil && driversLicense.AKASuffixName != "" {
            suffixName += "(" + driversLicense.AKASuffixName + ")"
        }

        firstName = firstName?.trimmingCharacters(in: .whitespaces)
        middleName = middleName?.trimmingCharacters(in: .whitespaces)
        

    }

    private func makeName() -> String {

    }

    private func refreshData() {
        self.labelName = (driversLicense.firstName ?? "") + driversLicense.FirstNameTruncationFlag ? "..."  + " " +
                (driversLicense.middleNames ?? "") + " " +
                (driversLicense.familyName)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
