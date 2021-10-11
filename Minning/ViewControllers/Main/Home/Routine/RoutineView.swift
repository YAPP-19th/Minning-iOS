//
//  RoutineView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import SnapKit

class RoutineView: UIView {

    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        mainCollectionView.backgroundColor = .clear
        
        [mainCollectionView].forEach {
            addSubview($0)
        }
        
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainCollectionView.register(RoutineHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RoutineHeaderView.identifier)
        mainCollectionView.register(RoutineCollectionViewCell.self, forCellWithReuseIdentifier: RoutineCollectionViewCell.identifier)
    }

}

extension RoutineView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension RoutineView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = mainCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RoutineHeaderView.identifier, for: indexPath) as? RoutineHeaderView else {
            return UICollectionReusableView()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: RoutineCollectionViewCell.identifier, for: indexPath) as? RoutineCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure()
        return cell
    }
}

extension RoutineView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: frame.width - 32, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width - 32, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 14, left: 16, bottom: .zero, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
