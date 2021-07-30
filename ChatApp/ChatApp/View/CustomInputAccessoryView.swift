//
//  CustomInputAccessoryView.swift
//  ChatApp
//
//  Created by mac on 26/07/2021.
//

import UIKit

protocol CustomInputAcessoryDelegate: AnyObject {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
}

class CustomInputAccessoryView: UIView {
    //  MARK: - Properties
    
    weak var messageDelegate: CustomInputAcessoryDelegate?
    
    public let messageInputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        return tv
    }()
    
    private lazy var sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Send", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return btn
    }()
    
    private let placeholderLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Enter message"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    //  MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        autoresizingMask = .flexibleHeight
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor,
                                    right: sendButton.leftAnchor, paddingTop: 12, paddingLeft: 4, paddingBottom: 8, paddingRight: 8 )
        
        addSubview(placeholderLabel)
        placeholderLabel.centerY(inView: messageInputTextView, leftAnchor: messageInputTextView.leftAnchor, paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    //  MARK: - Selectors
    
    @objc func handleSendMessage() {
        guard let text = messageInputTextView.text else { return }
        messageDelegate?.inputView(self, wantsToSend: text)
    }
    
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !messageInputTextView.text.isEmpty
    }
    
    //  MARK: - Helpers
    
}
