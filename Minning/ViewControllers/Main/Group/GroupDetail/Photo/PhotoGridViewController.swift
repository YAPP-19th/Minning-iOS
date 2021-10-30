//
//  PhotoGridViewController.swift
//  Minning
//
//  Created by 고세림 on 2021/10/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class PhotoGridViewController: BaseViewController {
    
    private let navigationBar: PlainUINavigationBar = PlainUINavigationBar()
    private lazy var rightBarButton = UIBarButtonItem(customView: rightBarButtonTitleLabel)

    private lazy var rightBarButtonTitleLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .black
        $0.text = "선택"
        return $0
    }(UILabel())
    
    private lazy var mainCollectionView: UICollectionView = {
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private let deletePhotoButton: UIButton = {
        $0.backgroundColor = .primaryWhite
        $0.setTitle("삭제하기", for: .normal)
        $0.setTitleColor(.minningDarkGray100, for: .normal)
        $0.titleLabel?.font = .font17P
        $0.isEnabled = false
        $0.isHidden = true
        return $0
    }(UIButton())
    
    private let viewModel: PhotoGridViewModel
    
    public init(viewModel: PhotoGridViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func setupViewLayout() {
        [navigationBar, mainCollectionView, deletePhotoButton].forEach {
            view.addSubview($0)
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        deletePhotoButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(49)
        }
    }
    
    private func setupNavigationBar() {
        navigationBar.removeDefaultShadowImage()
        
        let navigationItem = UINavigationItem()
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "close"), style: .plain, target: self, action: #selector(onClickCloseButton(_:))))
        navigationItem.setRightPlainBarButtonItems([rightBarButton])
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.titleContent = "그룹"
    }

    private func updateRightBarButton() {
        let targetString = viewModel.selectedItemCount == 0 ? "" : "\(viewModel.selectedItemCount) "
        let fullText = "\(targetString)선택"
        let range = (fullText as NSString).range(of: targetString)
        let valueAttrString = NSMutableAttributedString(string: fullText)
        valueAttrString.addAttributes([.font: UIFont.font16P,
                                       .foregroundColor: UIColor.blue], range: range)
        rightBarButtonTitleLabel.attributedText = valueAttrString
    }
    
    @objc
    private func onClickCloseButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { return .init() }
        return cell
    }
}

extension PhotoGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (mainCollectionView.frame.width - 14) / 3
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 5, bottom: 53, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
