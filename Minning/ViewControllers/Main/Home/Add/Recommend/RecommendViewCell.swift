//
//  RecommendViewCell.swift
//  Minning
//
//  Created by 박지윤 on 2021/10/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

class RecommendViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let identifier = "RecommendViewCell"

    private var color: UIColor = UIColor()
    
    private var subtitle: [String] = []
    private var contents: [String] = []
    
    private var recommendLabel: UILabel = {
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
    private let layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        return $0
    }(UICollectionViewFlowLayout())
    
    lazy var recommendCollectionView: UICollectionView = {
        $0.backgroundColor = .white
        $0.register(RecommendCell.self, forCellWithReuseIdentifier: RecommendCell.identifier)
        $0.isScrollEnabled = true
        $0.delegate = self
        $0.dataSource = self
        return $0
    }(UICollectionView(frame: frame, collectionViewLayout: layout))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewLayout()
        isUserInteractionEnabled = true
    }
    
    func setRecommendData(subtitle: [String], contents: [String], color: UIColor) {
        self.subtitle = subtitle
        self.contents = contents
        self.color = color
    }
    
    func setRecommendTitle(title: String) {
        self.recommendLabel.text = title
    }
    
    func setupViewLayout() {
        layout.scrollDirection = .horizontal
        
        backgroundColor = .white
        
        addSubview(recommendLabel)
        addSubview(recommendCollectionView)
        
        selectionStyle = .none
        
        recommendLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(100)
            make.trailing.equalToSuperview()
            make.width.equalTo(500)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCell.identifier, for: indexPath) as? RecommendCell {
            cell.titleLabel.text = subtitle[indexPath.row]
            cell.contentLabel.text = contents[indexPath.row]
            cell.titleLabel.textColor = color
            return cell
        }
        print("ERROR")
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subtitle.count
    }
}
