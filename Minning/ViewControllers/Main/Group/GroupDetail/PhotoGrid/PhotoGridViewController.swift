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
        $0.textColor = .primaryBlack
        $0.text = "선택"
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickSelectLabel(_:))))
        $0.frame = .init(x: 0, y: 0, width: 50, height: 16)
        $0.textAlignment = .right
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
        $0.addTarget(self, action: #selector(onClickDeleteButton(_:)), for: .touchUpInside)
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
    
    override func bindViewModel() {
        viewModel.selectedPhotoIndices.bindAndFire { [weak self] _ in
            guard let `self` = self else { return }
            self.updateRightBarButton()
            self.updateDeleteButton()
        }
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
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        deletePhotoButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(49)
        }
    }
    
    private func setupNavigationBar() {
        navigationBar.removeDefaultShadowImage()
        
        let navigationItem = UINavigationItem()
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickCloseButton(_:))))
        navigationItem.setRightPlainBarButtonItems([rightBarButton])
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.titleContent = "그룹"
    }

    private func updateRightBarButton() {
        guard mainCollectionView.allowsMultipleSelection else { return }
        let selectedItemCount = viewModel.selectedPhotoIndices.value.count
        let targetString = selectedItemCount == 0 ? "" : "\(selectedItemCount) "
        let fullText = "\(targetString)취소"
        let range = (fullText as NSString).range(of: targetString)
        let valueAttrString = NSMutableAttributedString(string: fullText)
        valueAttrString.addAttributes([.font: UIFont.font16P,
                                       .foregroundColor: UIColor.blue007AFF], range: range)
        rightBarButtonTitleLabel.attributedText = valueAttrString
    }
    
    private func updateDeleteButton() {
        let selectedItemCount = viewModel.selectedPhotoIndices.value.count
        deletePhotoButton.titleLabel?.textColor = selectedItemCount == 0 ? .minningDarkGray100 : .subAlert
    }
    
    @objc
    private func onClickCloseButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func onClickSelectLabel(_ sender: Any?) {
        if mainCollectionView.allowsMultipleSelection {
            viewModel.deselectAllPhotos()
            mainCollectionView.reloadData()
        }
        mainCollectionView.allowsMultipleSelection.toggle()
        rightBarButtonTitleLabel.text = mainCollectionView.allowsMultipleSelection ? "취소" : "선택"
        deletePhotoButton.isHidden = !mainCollectionView.allowsMultipleSelection
    }
    
    @objc
    private func onClickDeleteButton(_ sender: Any?) {
        DebugLog("Did Click Delete Button")
    }
}

extension PhotoGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { return .init() }
        cell.updateLayout(isSelected: viewModel.selectedPhotoIndices.value.contains(indexPath.row))
        return cell
    }
}

extension PhotoGridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView.allowsMultipleSelection else { return }
        if viewModel.selectedPhotoIndices.value.contains(indexPath.row) {
            viewModel.deselectPhoto(index: indexPath.row)
        } else {
            viewModel.selectPhoto(index: indexPath.row)
        }
        collectionView.reloadData()
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
