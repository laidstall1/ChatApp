//
//  ChatController.swift
//  ChatApp
//
//  Created by mac on 24/07/2021.
//

import UIKit

class ChatController: UICollectionViewController {

//    MARK: - Properties
    
    private let user: User
    
    private lazy var customInputView: UIView = {
        let container = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        return container
    }()
 
    //    MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("Debug: User in chat controller is \(user.username)")
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
//    MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        configureNavBar(withTitle: user.username, false)
        
        view.addSubview(customInputView)
        customInputView.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        customInputView.setDimensions(height: 60, width: view.frame.size.width)
    }
}
