//
//  DriversLicenseViewController.swift
//  DriversLicenseScan
//
//  Created by Gardner von Holt on 12/26/21.
//

import UIKit

class DriversLicenseViewController: UIViewController {

    var driversLicense: DriversLicense!

    @IBOutlet weak var labelPageTitle: UILabel!

    var licenseItemCollection: LicenseCollection!
    var licenseItemCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.onDataChanged()
        self.loadLicenseItems()
    }

    func loadLicenseItems() {
        self.licenseItemCollection = LicenseCollection(viewController: self, driversLicense: driversLicense)
        let listLayout = self.licenseItemCollection.makeListLayout()
        self.licenseItemCollectionView = licenseItemCollection.makeCollectionView(view: self.view, layout: listLayout, belowView: labelPageTitle)
        let licenseItemCellRegistration = licenseItemCollection.makeCellRegistrtion()
        licenseItemCollection.makeDataSource(collectionView: self.licenseItemCollectionView, cellRegistration: licenseItemCellRegistration)
    }

        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func onDataChanged() {
        DispatchQueue.main.async {
            self.licenseItemCollection.redisplayViewers()
        }
    }
}

