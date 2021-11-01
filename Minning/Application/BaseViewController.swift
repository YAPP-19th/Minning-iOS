//
//  BaseViewController.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

public class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    public var isKeyboardShowing: Bool = false
    public var observers: [NSObjectProtocol] = []
    weak var tabBarDelegate: MainTabBarDelegate?
    
    open var keyboardInsetsAdjustingScrollView: UIScrollView? {
        return nil
    }
    
    // Keyboard Observation
    open var registerKeyboardObservers: Bool {
        return false
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryWhite
        
        if registerKeyboardObservers {
            registerKeyboardNotifications()
        }
        
        setupViewLayout()
        bindViewModel()
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    open func setupDefaultNavigationBarStyle() {
        edgesForExtendedLayout = [.bottom, .left, .right]
        navigationController?.navigationBar.isTranslucent = false
        
        if let bar = navigationController?.navigationBar as? PlainUINavigationBar {
            bar.setDefaultShadowImage()
        }
    }
    
    open func pushViewController(_ viewController: UIViewController?, animated: Bool = true, bottomBarHidden: Bool = false) {
        if let viewController = viewController, let navigationController = navigationController {
            if bottomBarHidden {
                viewController.hidesBottomBarWhenPushed = bottomBarHidden
            }
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    open func registerKeyboardNotifications() {
        let observer = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { [weak self] notification in
            self?.adjustForKeyboard(notification: notification)
        })
        observers.append(observer)
        
        let changeObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil, using: { [weak self] notification in
            self?.adjustForKeyboard(notification: notification)
        })
        observers.append(changeObserver)
    }
    
    open func adjustForKeyboard(notification: Notification) {
        if !isKeyboardShowing {
            return
        }
        
        guard let scrollView = keyboardInsetsAdjustingScrollView else { return }
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        var inset = scrollView.contentInset
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            inset.bottom = 0
        } else {
            inset.bottom = keyboardViewEndFrame.height
            inset.bottom -= view.safeAreaInsets.bottom
        }
        scrollView.contentInset = inset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        observers.forEach { NotificationCenter.default.removeObserver($0) }
        observers = []
    }
    
    public func showAlert(title: String?, message: String?, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: handler)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    public func showAlert(title: String?, message: String?, okTitle: String, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: handler)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    public func bindViewModel() { }
    public func setupViewLayout() { }
}
