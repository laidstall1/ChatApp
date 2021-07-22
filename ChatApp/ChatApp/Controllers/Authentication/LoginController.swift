//
//  LoginController.swift
//  ChatApp
//
//  Created by mac on 13/07/2021.
//

import UIKit

class LoginController: UIViewController {
    
    private var viewModel = LoginViewModel()
    
    // MARK: - Properties
    
    private let iconImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "bubble.right")
        img.tintColor = .white
        return img
    }()
    
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(textfield: emailTextfield,
                                  image: UIImage(systemName: "envelope"))
    }()
    
    private let emailTextfield: CustomTextField =  CustomTextField(placeholder: "Email")
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(textfield: passwordTextfield,
                                  image: UIImage(systemName: "lock"))
    }()
    
    private let passwordTextfield: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 )
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        btn.layer.cornerRadius = 5
        btn.isEnabled = false
        btn.setHeight(height: 50)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()

    private let dontHaveAcctBtn: UIButton = {
        let btn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white ])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Selectors
    
    @objc func handleLogin() {
        print("warris going on")
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailTextfield {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func handleShowSignUp() {
        let vc = SignUpController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helpers
   
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.setDimensions(height: 120, width: 150)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,  paddingTop: 32)
        iconImage.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(loginBtn)
        loginBtn.anchor(top: stack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 32)
        
        view.addSubview(dontHaveAcctBtn)
        dontHaveAcctBtn.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0)
        dontHaveAcctBtn.centerX(inView: view)
        
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
}

extension LoginController: AuthenticationControllerProtocol {
    func checkFormStatus() {
        switch viewModel.formIsValid {
        case true:
            loginBtn.isEnabled = true
            loginBtn.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case false:
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
