//
//  RoutineView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import SnapKit

protocol RoutineViewDelegate: AnyObject {
    func didSelectPhraseGuide()
}

class RoutineView: UIView {
    
    enum CollectionViewSection: Int, CaseIterable {
        case header
        case phraseGuide
        case routine
        case review
    }
    
    weak var delegate: RoutineViewDelegate?

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
        mainCollectionView.register(PhraseGuideCell.self, forCellWithReuseIdentifier: PhraseGuideCell.identifier)
        mainCollectionView.register(RoutineCollectionViewCell.self, forCellWithReuseIdentifier: RoutineCollectionViewCell.identifier)
    }

}

extension RoutineView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch CollectionViewSection(rawValue: section) {
        case .header:
            return 0
        case .phraseGuide:
            return 1
        case .routine:
            return 3
        case .review:
            return 0
        default:
            return 0
        }
    }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CollectionViewSection.allCases.count
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
        switch CollectionViewSection(rawValue: indexPath.section) {
        case .header:
            return .init()
        case .phraseGuide:
            guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: PhraseGuideCell.identifier, for: indexPath) as? PhraseGuideCell else {
                return UICollectionViewCell()
            }
            return cell
        case .routine:
            guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: RoutineCollectionViewCell.identifier, for: indexPath) as? RoutineCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure()
            return cell
        case .review:
            return .init()
        default:
            return .init()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch CollectionViewSection(rawValue: indexPath.section) {
        case .header:
            break
        case .phraseGuide:
            delegate?.didSelectPhraseGuide()
        case .routine:
            break
        case .review:
            break
        default:
            break
        }
    }
}

extension RoutineView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch CollectionViewSection(rawValue: section) {
        case .header:
            return .init(width: frame.width - 32, height: 56)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch CollectionViewSection(rawValue: indexPath.section) {
        case .header:
            return .zero
        case .phraseGuide:
            return .init(width: frame.width - 32, height: 50)
        case .routine:
            return .init(width: frame.width - 32, height: 70)
        case .review:
            return .zero
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch CollectionViewSection(rawValue: section) {
        case .header:
            return .zero
        case .phraseGuide:
            return .init(top: 14, left: 16, bottom: .zero, right: 16)
        case .routine:
            return .init(top: 14, left: 16, bottom: .zero, right: 16)
        case .review:
            return .zero
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch CollectionViewSection(rawValue: section) {
        case .header:
            return .zero
        case .phraseGuide:
            return .zero
        case .routine:
            return 8
        case .review:
            return .zero
        default:
            return .zero
        }
    }
}
