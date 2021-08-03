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
    private let viewModel = ConversationsServiceViewModel()
    private var conversations = [Conversation]()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavBar(withTitle: "Messages", true)
        fetchConversations()
    }
    
    // MARK: - Selectors
    
    @objc func showProfile(){
        let controller = ProfileController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func showNewMessage() {
        let vc = NewMessageController()
        vc.newMessageDelegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    // MARK: - API
    
    func fetchConversations(){
        viewModel.fetchConversations { conversation in
            DispatchQueue.main.async {
                self.conversations = conversation
                self.tableView.reloadData()
            }
        }
    }
    
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
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
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
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        return cell
    }
}

//  MARK: - UITableViewDelegate

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = conversations[indexPath.row].user
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, startChatWithUser user: User) {
        dismiss(animated: true, completion: nil)
        let chatController = ChatController(user: user)
        navigationController?.pushViewController(chatController, animated: true)
    }
}
