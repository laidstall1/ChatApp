//
//  LoginController.swift
//  ChatApp
//
//  Created by mac on 13/07/2021.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "bubble.right")
        img.tintColor = .white
        return img
    }()
    
    private let emailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        let img = UIImageView()
        img.image = UIImage(systemName: "envelope")
        img.tintColor = .white
        
        view.addSubview(img)
        img.centerY(inView: view)
        img.anchor(left: view.leftAnchor, paddingLeft: 8)
        img.setDimensions(height: 20, width: 24)
        
        view.setHeight(height: 50)
        return view
    }()
    
    private let passwordContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        let iv = UIImageView()
        iv.image = UIImage(systemName: "lock")
        iv.tintColor = .white
        
        view.addSubview(iv)
        iv.centerY(inView: view)
        iv.anchor(left: view.leftAnchor, paddingLeft: 8)
        iv.setDimensions(height: 20, width: 24)
        
        view.setHeight(height: 50)
        return view
    }()
    
    private let loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .cyan
        btn.setHeight(height: 50)
        return btn
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 100, width: 120)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginBtn])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemTeal.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }

}
