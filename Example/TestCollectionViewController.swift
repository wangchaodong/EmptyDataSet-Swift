//
//  TestCollectionViewController.swift
//  Example
//
//  Created by s1mple wang on 5/28/23.
//  Copyright © 2023 Xiaoye. All rights reserved.
//

import EmptyDataSet_Swift
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0 ... 1),
            green: .random(in: 0 ... 1),
            blue: .random(in: 0 ... 1),
            alpha: 1.0
        )
    }
}

class TestGridCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .random
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TestGridHeader: UICollectionReusableView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .random
    }
}

class TestCollectionViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let co = UICollectionView(frame: .zero, collectionViewLayout: layout)
        co.backgroundColor = .cyan
        return co
    }()

    var sectionList = [Int](0 ... 10)
    var rowList = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.register(TestGridCell.self, forCellWithReuseIdentifier: "TestGridCell")
        collectionView.register(TestGridHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TestGridHeader")
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightBarButtonItemClick))

        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
//        collectionView.emptyDataSetView { [weak self] emptyView in
//            let imagV = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
//            imagV.image = UIImage(named: "icon_wwdc")
//            emptyView.customView(imagV)
//                .useSectionCountForDisplay(true)
//        }
    }

    @objc func rightBarButtonItemClick() {
        if sectionList.count > 0 {
            sectionList.removeAll()
        } else {
            sectionList = [Int](0 ... 10)
        }
        collectionView.reloadData()
    }
}

extension TestCollectionViewController: EmptyDataSetSource, EmptyDataSetDelegate {
    func shouldUseSectionCountForDisplay() -> Bool {
        true
    }

    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        let imagV = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
        imagV.image = UIImage(named: "icon_wwdc")
        return imagV
    }
}

extension TestCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionList.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rowList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestGridCell", for: indexPath) as! TestGridCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TestGridHeader", for: indexPath) as! TestGridHeader
            return header
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: 200, height: 40)
    }
}
