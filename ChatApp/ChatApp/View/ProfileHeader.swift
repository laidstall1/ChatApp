//
//  ProfileHeader.swift
//  ChatApp
//
//  Created by mac on 02/08/2021.
//

import UIKit

protocol DismissControllerProtocol {
    func dismiss()
}

class ProfileHeader: UIView {
    
    var dismissDelegate: DismissControllerProtocol?
    
    //    MARK: - Properties
    private let dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = .white
        btn.imageView?.setDimensions(height: 25, width: 22)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 4
        iv.layer.borderColor = UIColor.white.cgColor
       return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "laid baba"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    private let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "@laidstall"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    
    //    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Selectors
    
    @objc func handleDismiss() {
        dismissDelegate?.dismiss()
    }
    
    //    MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        addSubview(dismissButton)
        dismissButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 20)
        
        addSubview(profileImageView)
        profileImageView.centerX(inView: self)
        profileImageView.centerY(inView: self)
        profileImageView.setDimensions(height: 200, width: 200)
        profileImageView.layer.cornerRadius = 200 / 2
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerX(inView: profileImageView)
        stack.anchor(top: profileImageView.bottomAnchor, paddingTop: 16)
        
    }
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        layer.addSublayer(gradient)
        gradient.frame = bounds
    }
}
