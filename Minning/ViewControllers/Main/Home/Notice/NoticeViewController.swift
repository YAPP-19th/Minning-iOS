//
//  NoticeViewController.swift
//  Minning
//
//  Created by denny on 2021/10/28.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class NoticeViewController: BaseViewController {
    lazy var notificationTableView: UITableView = {
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(NoticeItemCell.self, forCellReuseIdentifier: NoticeItemCell.identifier)
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    private let viewModel: NoticeViewModel
    
    public init(viewModel: NoticeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.createSampleDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "미닝 공지사항"
            navBar.removeDefaultShadowImage()
        }
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
    
    override func bindViewModel() {
        viewModel.sampleNotiList.bindAndFire { [weak self] _ in
            guard let `self` = self else { return }
            self.notificationTableView.reloadData()
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .minningLightGray100
        view.addSubview(notificationTableView)
        notificationTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension NoticeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sampleNotiList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NoticeItemCell.identifier) as? NoticeItemCell {
            cell.item = viewModel.sampleNotiList.value[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}
