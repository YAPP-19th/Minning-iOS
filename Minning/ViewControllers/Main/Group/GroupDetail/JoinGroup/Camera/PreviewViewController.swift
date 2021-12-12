//
//  PreviewViewController.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/06.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

class PreviewViewController: UIViewController {
    let imageView: UIImageView = {
        return $0
    }(UIImageView())
    
    let backBarButtonItem: UIBarButtonItem = {
        $0.image = UIImage(sharedNamed: "arrow_back")
        return $0
    }(UIBarButtonItem())
    
    var uploadButton: UIBarButtonItem = {
        $0.title = "업로드"
        return $0
    }(UIBarButtonItem())
    
    var imageWidth: CGFloat = 0
    var imageHeight: CGFloat = 0
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    init(image innerImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = innerImage
        imageWidth = innerImage.size.width
        imageHeight = innerImage.size.height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width)
        }
        
        navigationItem.rightBarButtonItem = uploadButton
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        uploadButton.addTargetForAction(target: self, action: #selector(uploadButtonPressed(_:)))
        
        backBarButtonItem.addTargetForAction(target: self, action: #selector(backButtonPressed(_:)))
    }
    
    @objc func backButtonPressed(_ sender: Any?) {
        let alert = UIAlertController(title: "사진 삭제", message: "뒤로가기를 누르면 사진이 삭제됩니다.\n정말 사진을 삭제하고 새로 찍으시겠습니까?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: false)
            CameraViewController().button.sendActions(for: .touchUpInside)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [cancelAction, deleteAction].forEach {
            alert.addAction($0)
        }
        
        present(alert, animated: false, completion: nil)
    }
    
    @objc func uploadButtonPressed(_ sender: Any?) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, nil, nil)
        navigationController?.popViewController(animated: true)
    }
}

extension UIBarButtonItem {
    func addTargetForAction(target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
}
