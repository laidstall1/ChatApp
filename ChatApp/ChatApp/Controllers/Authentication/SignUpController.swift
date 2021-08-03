//
//  SignUpController.swift
//  ChatApp
//
//  Created by mac on 13/07/2021.
//

import UIKit
import Firebase

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

class SignUpController: UIViewController {
    
    private var viewModel = SignUpViewModel()
    private var profileImage: UIImage?
    
    // MARK: - Properties
    
    private let uploadPhotoButton: UIButton  = {
        let uploadBtn = UIButton(type: .system)
        uploadBtn.setImage(UIImage(named: "plus_photo"), for: .normal)
        uploadBtn.tintColor = .white
        uploadBtn.clipsToBounds = true
        uploadBtn.imageView?.contentMode = .scaleAspectFill
        uploadBtn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return uploadBtn
    }()
    
    private lazy var emailContainerView: InputContainerView = InputContainerView(textfield: emailTextfield, image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"))
    
    private let emailTextfield: CustomTextField = CustomTextField(placeholder: "Email")
    
    private lazy var fullNameContainerView: InputContainerView = InputContainerView(textfield: fullNameTextfield, image: #imageLiteral(resourceName: "ic_person_outline_white_2x"))
    
    private let fullNameTextfield: CustomTextField = CustomTextField(placeholder: "Full Name")
    
    private lazy var usernameContainerView: InputContainerView = InputContainerView(textfield: usernameTextField, image: #imageLiteral(resourceName: "ic_person_outline_white_2x"))
    
    private let usernameTextField: CustomTextField = CustomTextField(placeholder: "Username")
    
    private lazy var passwordContainerView: InputContainerView = InputContainerView(textfield: passwordTextField, image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"))
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 )
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        btn.layer.cornerRadius = 5
        btn.isEnabled = false
        btn.setHeight(height: 50)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    }()
    
    private let dontHaveAcctBtn: UIButton = {
        let btn = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "Already  have an account?  ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "Log In", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        btn.setAttributedTitle(attributedText, for: .normal)
        btn.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Selectors
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextfield.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        guard let username = usernameTextField.text?.lowercased(), !username.isEmpty else { return }
        guard let fullName = fullNameTextfield.text, !fullName.isEmpty else { return }
        guard let profileImage = profileImage else { return }
        
        let credentials = RegistrationCredentials(email: email, password: password,
                                                  fullName: fullName, username: username,
                                                  profileImage: profileImage)
        
        showLoader(true, withText: "Signing you up")
        
        AuthService.shared.createUser(with: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to upload user data with \(error.localizedDescription)")
                self.showLoader(false)
                return
            }
            self.showLoader(false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        switch sender {
        case emailTextfield:
            viewModel.email = sender.text
        case fullNameTextfield:
            viewModel.fullName = sender.text
        case usernameTextField:
            viewModel.userName = sender.text
        case passwordTextField:
            viewModel.password = sender.text
        default:
            return
        }
        checkFormStatus()
    }
    
    @objc func handleShowLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Helpers
        
    fileprivate func configureNotificationObservers() {
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configureUI(){
        configureGradientLayer()
        
        view.addSubview(uploadPhotoButton)
        uploadPhotoButton.setDimensions(height: 200, width: 200)
        uploadPhotoButton.centerX(inView: view)
        uploadPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, fullNameContainerView, usernameContainerView, passwordContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: uploadPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAcctBtn)
        dontHaveAcctBtn.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0)
        dontHaveAcctBtn.centerX(inView: view)
        
        configureNotificationObservers()
    }
}

// MARK: - UIImagePickerControllerDelegate

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        uploadPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        uploadPhotoButton.layer.borderWidth = 3.0
        uploadPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        uploadPhotoButton.layer.cornerRadius = 100
        
        dismiss(animated: true, completion: nil)
    }
}


extension SignUpController: AuthenticationControllerProtocol {
    func checkFormStatus() {
        switch viewModel.formIsValid {
        case true:
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case false:
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
