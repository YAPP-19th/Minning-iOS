//
//  RoutineView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import SnapKit

protocol RoutineViewDelegate: AnyObject {
    func didSelectSection(_ section: RoutineView.TableViewSection)
    func didSelectEditOrder()
    func didSelectTab(_ tabType: HomeViewModel.RoutineTabType)
}

final class RoutineView: UIView {
    enum TableViewSection: Int, CaseIterable {
        case header
        case phraseGuide
        case groupGuide
        case routine
        case review
        case footer
    }
    
    weak var delegate: RoutineViewDelegate?
    var tabType: HomeViewModel.RoutineTabType = .routine
    var routines = [RoutineModel]()
    var retrospects = [RetrospectModel]()
    
    lazy var mainTableView: UITableView = {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.register(RoutineHeaderCell.self, forCellReuseIdentifier: RoutineHeaderCell.identifier)
        $0.register(PhraseGuideCell.self, forCellReuseIdentifier: PhraseGuideCell.identifier)
        $0.register(GroupGuideCell.self, forCellReuseIdentifier: GroupGuideCell.identifier)
        $0.register(RoutineCell.self, forCellReuseIdentifier: RoutineCell.identifier)
        $0.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        $0.register(RoutineFooterCell.self, forCellReuseIdentifier: RoutineFooterCell.identifier)
        return $0
    }(UITableView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        mainTableView.reloadData()
    }
    
    func updateViewWithRoutines(routines: [RoutineModel]) {
        self.routines = routines
        mainTableView.reloadData()
    }
    
    func updateViewWithRetrospects(retrospects: [RetrospectModel]) {
        self.retrospects = retrospects
        mainTableView.reloadData()
    }
    
    private func setupViewLayout() {
        mainTableView.backgroundColor = .clear
        addSubview(mainTableView)

        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension RoutineView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let section = TableViewSection(rawValue: indexPath.section) {
            delegate?.didSelectSection(section)
        }
    }
}

extension RoutineView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableViewSection(rawValue: section) {
        case .header:
            return 1
        case .phraseGuide:
            return tabType == .routine ? 1 : .zero
        case .groupGuide:
            return 0 // 명언 작성 완료 후 노출
        case .routine:
            return tabType == .routine ? routines.count : .zero
        case .review:
            return tabType == .routine ? .zero : retrospects.count
        case .footer:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TableViewSection(rawValue: indexPath.section) {
        case .header:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: RoutineHeaderCell.identifier, for: indexPath) as? RoutineHeaderCell else {
                return .init()
            }
            cell.configure(delegate: self, tabType: tabType)
            return cell
        case .phraseGuide:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: PhraseGuideCell.identifier, for: indexPath) as? PhraseGuideCell else {
                return .init()
            }
            return cell
        case .groupGuide:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: GroupGuideCell.identifier, for: indexPath) as? GroupGuideCell else {
                return .init()
            }
            return cell
        case .routine:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: RoutineCell.identifier, for: indexPath) as? RoutineCell else {
                return .init()
            }
            cell.configure(routines[indexPath.row])
            return cell
        case .review:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell else {
                return .init()
            }
            return cell
        case .footer:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: RoutineFooterCell.identifier, for: indexPath) as? RoutineFooterCell else {
                return .init()
            }
            cell.editOrderButtonHandler = { [weak self] in
                guard let delegate = self?.delegate else { return }
                return delegate.didSelectEditOrder()
            }
            return cell
        default:
            return .init()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch TableViewSection(rawValue: indexPath.section) {
        case .header:
            return 70
        case .phraseGuide:
            return 58
        case .groupGuide:
            return 58
        case .routine:
            return 78
        case .review:
            return 78
        case .footer:
            return 41
        default:
            return .zero
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == TableViewSection.routine.rawValue else { return nil }
        return nil
//
//        let completeAction = UIContextualAction(style: .normal, title: "") { (_, _, completion) in
//            print("complete")
//            completion(true)
//        }
//        completeAction.backgroundColor = .minningLightGray100
//        completeAction.image = convertSwipeViewToImage(action: .complete)
//
//        let halfAction = UIContextualAction(style: .normal, title: "") { (_, _, completion) in
//            print("half")
//            completion(true)
//        }
//        halfAction.backgroundColor = .minningLightGray100
//        halfAction.image = convertSwipeViewToImage(action: .half)
//
//        let dismissAction = UIContextualAction(style: .normal, title: "") { (_, _, completion) in
//            print("dismiss")
//            completion(true)
//        }
//        dismissAction.backgroundColor = .minningLightGray100
//        dismissAction.image = convertSwipeViewToImage(action: .dismiss)
//
//        return .init(actions: [halfAction, completeAction])
//
//        return .init(actions: [dismissAction])
    }
    
    private func convertSwipeViewToImage(action: RoutineCellSwipeView.Action) -> UIImage {
        let view = RoutineCellSwipeView(action: action)
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }
    }
}

extension RoutineView: RoutineHeaderCellDelegate {
    func didSelectRoutineTab() {
        delegate?.didSelectTab(.routine)
    }
    
    func didSelectReviewTab() {
        delegate?.didSelectTab(.review)
    }
}
