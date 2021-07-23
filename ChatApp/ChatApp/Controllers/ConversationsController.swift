//
//  ConversationViewController.swift
//  ChatApp
//
//  Created by mac on 13/07/2021.
//

import UIKit
import Firebase

private let reuseIdentifier = "cell"

class ConversationsController: UIViewController {

    // MARK: - Properties
    private let tableView = UITableView()
    
    private let newMessageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.backgroundColor = .systemPurple
        btn.tintColor = .white
        btn.imageView?.setDimensions(height: 24, width: 24)
        btn.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
       authenticateUser()
    }
    
    // MARK: - Selectors
    
    @objc func showProfile(){
        logout()
    }
    
    @objc func showNewMessage() {
        let vc = NewMessageController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    // MARK: - API
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
            debugPrint("DEBUG: User is not logged in. Present login screen... ")
        } else {
            print("User is logged in, current user ID is: \(String(describing: Auth.auth().currentUser?.uid))")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("DEBUG: Error logging user out...")
        }
    }
    
    // MARK: - Helpers
    
    func presentLoginScreen() {
        let vc = LoginController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func configureUI(){
        view.backgroundColor = .white
        configureNavBar(withTitle: "Messages", true)
        configureTableView()
        let navImage = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: navImage, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(height: 56, width: 56)
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
        newMessageButton.layer.cornerRadius = 56 / 2
    }
    
    func configureTableView(){
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

//  MARK: - UITableViewDataSource

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Testing"
        return cell
    }
}

//  MARK: - UITableViewDelegate

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
