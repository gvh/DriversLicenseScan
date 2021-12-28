//
//  LicenseCollection.swift
//  DriversLicenseScan
//
//  Created by Gardner von Holt on 12/27/21.
//

import UIKit

class LicenseCollection: NSObject {
    var driversLicense: DriversLicense
    var driversLicenseDisplay: DriversLicenseDisplay
    private var licenseItems: [LicenseItem] = []

    let themeColor = UIColor(red: 27.0/255.0, green: 65.0/255.0, blue: 93.0/255.0, alpha: 1.0)
    let barThemeColor = UIColor(red: (27.0 - 20.0)/255.0, green: (65.0 - 20.0)/255.0, blue: (93.0 - 20.0)/255.0, alpha: 1.0)

    var collectionView: UICollectionView!
    var dataSource: LicenseItemDataSource!
    var viewController: UIViewController

    enum Section {
        case licenseItem
    }

    typealias LicenseItemDataSource = UICollectionViewDiffableDataSource<Section, LicenseItem>
    typealias LicenseItemSnapshot = NSDiffableDataSourceSnapshot<Section, LicenseItem>
    typealias LicenseItemCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LicenseItem>

    init(viewController: UIViewController, driversLicense: DriversLicense) {
        self.viewController = viewController
        self.driversLicense = driversLicense
        self.driversLicenseDisplay = DriversLicenseDisplay(self.driversLicense)
        super.init()
        redisplayViewers()
    }

    func redisplayViewers(animatingDifferences: Bool = true) {
        var snapshot = LicenseItemSnapshot()
        snapshot.appendSections([.licenseItem])
        self.licenseItems.removeAll()
        self.licenseItems.append(contentsOf: driversLicenseDisplay.items)
        self.licenseItems.sort(by: { $0.sequence < $1.sequence })
        snapshot.appendItems(self.licenseItems, toSection: .licenseItem)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func makeListLayout() -> UICollectionViewCompositionalLayout {
        // Create list layout
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfig.backgroundColor = themeColor
        layoutConfig.showsSeparators = false
        layoutConfig.headerMode = .none

        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        return listLayout
    }

    func makeCollectionView(view: UIView, layout: UICollectionViewCompositionalLayout, belowView: UIView) -> UICollectionView {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = themeColor
        collectionView.backgroundView?.backgroundColor = themeColor

        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: belowView.bottomAnchor, constant: 24.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
        ])
        return collectionView
    }

    func makeCellRegistrtion() -> LicenseItemCellRegistration {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LicenseItem> { (cell, _, item) in

            var content = cell.defaultContentConfiguration()

            content.text = item.label
            content.textProperties.adjustsFontSizeToFitWidth = true
            content.textProperties.minimumScaleFactor = 0.25
            content.textProperties.numberOfLines = 1

            content.secondaryText = item.value
            content.secondaryTextProperties.adjustsFontSizeToFitWidth = true
            content.secondaryTextProperties.minimumScaleFactor = 0.25
            content.secondaryTextProperties.numberOfLines = 1

            cell.contentConfiguration = content

            var backgroundConfig = cell.backgroundConfiguration
            backgroundConfig?.backgroundColor = .clear
            cell.backgroundConfiguration = backgroundConfig
            cell.backgroundColor = self.themeColor
        }
        return cellRegistration
    }

    func makeDataSource(collectionView: UICollectionView, cellRegistration: LicenseItemCellRegistration) {
        self.dataSource = LicenseItemDataSource(collectionView: collectionView,
                                           cellProvider: { (collectionView, indexPath, licenseItem) -> UICollectionViewCell?  in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: licenseItem)
            return cell
        })
    }
}
