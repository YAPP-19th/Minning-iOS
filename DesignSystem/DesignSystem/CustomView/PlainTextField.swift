//
//  PlainTextField.swift
//  DesignSystem
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import SharedAssets
import SnapKit
import UIKit

public class PlainTextField: UITextField {
    internal var isDisabled: Bool = false {
        didSet { }
    }
    
    internal var isMasked: Bool = true {
        didSet { }
    }
    
    public override var placeholder: String? {
        didSet {
            if let text = placeholder {
                attributedPlaceholder = NSAttributedString(
                    string: text,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.primaryGray]
                )
            }
        }
    }
    
    private let clearButton: ImageButton = {
        $0.setImage(UIImage(sharedNamed: "ClearButton"), for: .normal)
        $0.addTarget(self, action: #selector(onClickClearButton(_:)), for: .touchUpInside)
        return $0
    }(ImageButton())
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onClickClearButton(_ sender: ImageButton?) {
        text = ""
        sendActions(for: .editingChanged)
    }
    
    private func setupView() {
        self.font = .font16PMedium
        self.rightView = clearButton
        self.rightViewMode = .always
        
        self.layer.cornerRadius = Constant.Rounding.rad10
        self.backgroundColor = .primaryWhite
        self.snp.makeConstraints {
            $0.height.equalTo(Constant.Height.textField)
        }
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.offsetBy(dx: -16, dy: 0)
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0,
                                             left: 16,
                                             bottom: 0,
                                             right: 16 + 20 + 16
        ))
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0,
                                             left: 16,
                                             bottom: 0,
                                             right: 16 + 20 + 4
        ))
    }
}
