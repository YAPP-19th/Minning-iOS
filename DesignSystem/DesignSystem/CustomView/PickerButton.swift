//
//  PickerButton.swift
//  DesignSystem
//
//  Created by denny on 2022/02/19.
//  Copyright © 2022 Minning. All rights reserved.
//

import Foundation
import UIKit

public protocol CRPickerButtonDelegate: AnyObject {
    func pickerView(_ pickerView: UIPickerView, titleForRow: Int)
}

public class CRPickerButton: UIButton {
    
    public let pickerView = UIPickerView()
    
    public var pickerViewDelegate: UIPickerViewDelegate? {
        get {
            return pickerView.delegate
        }
        set {
            return pickerView.delegate = newValue
        }
    }
    public var pickerViewDataSource: UIPickerViewDataSource? {
        get {
            return pickerView.dataSource
        }
        set {
            return pickerView.dataSource = newValue
        }
    }
    
    public weak var delegate: CRPickerButtonDelegate?
    
    public override var inputView: UIView? {
        return pickerView
    }
    
    public override var inputAccessoryView: UIView? {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 44)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        let closeButton = UIBarButtonItem(
            title: closeButtonTitle,
            style: .plain,
            target: self,
            action: #selector(didTapClose(_:))
        )
        closeButton.tintColor = closeButtonTintColor
        let space = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: doneButtonTitle,
            style: .done,
            target: self,
            action: #selector(didTapDone(_:))
        )
        doneButton.tintColor = doneButtonTintColor
        
        let items = [closeButton, space, doneButton]
        toolbar.setItems(items, animated: false)
        toolbar.sizeToFit()
        toolbar.updateConstraintsIfNeeded()
        
        return toolbar
    }
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Variables
    private var closeButtonTitle: String = "Close"
    private var doneButtonTitle: String = "Done"
    private var closeButtonTintColor: UIColor = .systemBlue
    private var doneButtonTintColor: UIColor = .systemBlue
    
    // MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    // MARK: - Public Methods
    public func reloadData() {
        pickerView.reloadAllComponents()
    }
    
    public func setTitleForCloseButton(_ title: String, color: UIColor = .systemBlue) {
        closeButtonTitle = title
        closeButtonTintColor = color
    }
    
    public func setTitleForDoneButton(_ title: String, color: UIColor = .systemBlue) {
        doneButtonTitle = title
        doneButtonTintColor = color
    }
    
    public func setBackgroundColorForPicker(color: UIColor) {
        pickerView.backgroundColor = color
    }
    
}

@objc
extension CRPickerButton {
    private func didTapClose(_ button: UIBarButtonItem) {
        closePickerView()
    }
    
    private func didTapDone(_ button: UIBarButtonItem) {
        let row = pickerView.selectedRow(inComponent: pickerView.numberOfComponents - 1)
        delegate?.pickerView(pickerView, titleForRow: row)
        if let title = pickerView.delegate?.pickerView?(pickerView, titleForRow: row, forComponent: pickerView.numberOfComponents) {
            setTitle(title, for: .normal)
        } else {
            assertionFailure("Failed to get pickerView value.")
        }
        closePickerView()
    }
    
    private func didTapButton() {
        becomeFirstResponder()
    }
    
}

extension CRPickerButton {
    private func configureView() {
        pickerView.delegate = pickerViewDelegate
        pickerView.dataSource = pickerViewDataSource
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func closePickerView() {
        resignFirstResponder()
    }
    
}
