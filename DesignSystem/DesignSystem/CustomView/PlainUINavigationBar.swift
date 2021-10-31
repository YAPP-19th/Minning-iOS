//
//  PlainUINavigationBar.swift
//  DesignSystem
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import UIKit

public class PlainUINavigationBar: UINavigationBar {
    private let emptyShadowImage: UIImage = UIImage(color: UIColor.clear, size: CGSize(width: 1, height: 1.0 / UIScreen.main.scale))
    private var defaultShadowImage: UIImage?
    
    private let titleLabel: UILabel = {
        $0.textColor = .black
        $0.font = .font16PMedium
        return $0
    }(UILabel())
    
    public var titleContent: String = "" {
        didSet {
            titleLabel.text = titleContent
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .primaryWhite
            appearance.shadowColor = nil
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func setDefaultPlainNavigationStyle() {
        isTranslucent = false
        tintColor = .black
        backgroundColor = .primaryWhite
    }
    
    public func setDefaultShadowImage() {
        guard shadowImage != defaultShadowImage else { return }
        shadowImage = defaultShadowImage
    }
    
    public func removeDefaultShadowImage() {
        guard shadowImage != emptyShadowImage else { return }
        shadowImage = emptyShadowImage
    }
    
    func reloadShadowImages() {
        defaultShadowImage = UIImage(color: UIColor.black.withAlphaComponent(0.15),
                                     size: CGSize(width: 1, height: 1.0 / UIScreen.main.scale))
    }
}

public extension UINavigationItem {
    func setRightPlainBarButtonItem(_ item: UIBarButtonItem?, animated: Bool) {
        guard let item = item else {
            rightBarButtonItem = nil
            rightBarButtonItems = nil
            return
        }
        
        setRightBarButton(item, animated: animated)
    }
    
    func setRightPlainBarButtonItems(_ items: [UIBarButtonItem]?, animated: Bool) {
        guard let items = items else {
            rightBarButtonItem = nil
            rightBarButtonItems = nil
            return
        }
        
        let buttonItems: [UIBarButtonItem] = items
        setRightBarButtonItems(buttonItems, animated: animated)
    }
    
    func setRightPlainBarButtonItems(_ items: [UIBarButtonItem]?) {
        setRightPlainBarButtonItems(items, animated: false)
    }
    
    func setLeftPlainBarButtonItem(_ item: UIBarButtonItem?, animated: Bool) {
        guard let item = item else {
            setLeftBarButton(nil, animated: animated)
            setLeftBarButtonItems(nil, animated: animated)
            return
        }
        
        setLeftBarButton(item, animated: animated)
    }
    
    func setLeftPlainBarButtonItems(_ items: [UIBarButtonItem]?, animated: Bool) {
        guard let items = items else {
            leftBarButtonItem = nil
            leftBarButtonItems = nil
            return
        }
        
        let buttonItems: [UIBarButtonItem] = items
        setLeftBarButtonItems(buttonItems, animated: animated)
    }
    
    func setLeftPlainBarButtonItem(_ item: UIBarButtonItem?) {
        setLeftPlainBarButtonItem(item, animated: false)
    }
    
    var rightPlainBarButtonItem: UIBarButtonItem? {
        if rightBarButtonItems != nil && rightBarButtonItems!.count > 0 {
            return rightBarButtonItems?.last
        }
        if rightBarButtonItem != nil {
            return rightBarButtonItem
        }
        return nil
    }
    
    var rightPlainBarButtonItems: [UIBarButtonItem]? {
        if rightBarButtonItems != nil {
            return rightBarButtonItems
        }
        if rightBarButtonItem != nil {
            return [rightBarButtonItem!]
        }
        return nil
    }
    
    var leftPlainBarButtonItem: UIBarButtonItem? {
        if leftBarButtonItems != nil && leftBarButtonItems!.count > 0 {
            return leftBarButtonItems?.last
        }
        if leftBarButtonItem != nil {
            return leftBarButtonItem
        }
        return nil
    }
    
    var leftPlainBarButtonItems: [UIBarButtonItem]? {
        if leftBarButtonItems != nil {
            return leftBarButtonItems
        }
        if leftBarButtonItem != nil {
            return [leftBarButtonItem!]
        }
        return nil
    }
    
    func setRightBarButtonItemEnabled(_ enabled: Bool) {
        rightPlainBarButtonItem?.isEnabled = enabled
    }
    
    func setLeftBarButtonItemEnabled(_ enabled: Bool) {
        leftPlainBarButtonItem?.isEnabled = enabled
    }
}
