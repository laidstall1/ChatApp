//
//  NewMessageController.swift
//  ChatApp
//
//  Created by mac on 23/07/2021.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: AnyObject {
    func controller(_ controller: NewMessageController, startChatWithUser user: User)
}

class NewMessageController: UITableViewController {

//    MARK: - Properties
    
    private var viewModel = NewMessageViewModel()
    weak var newMessageDelegate: NewMessageControllerDelegate?
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
//    MARK: - Selectors
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
//    MARK: - API
    func fetchUsers() {
        DispatchQueue.main.async {
            self.viewModel.fetchUsers {
            self.tableView.reloadData()
            }
        }
    }
    
//    MARK: - Helpers
    
    func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavBar(withTitle: "New Message", false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        configureTableView()
    }
}

//  MARK: - UITableViewDatasource

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = viewModel.users[indexPath.row]
        return cell
    }
}

//  MARK: - UITableViewDataSource

extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newMessageDelegate?.controller(self, startChatWithUser: viewModel.users[indexPath.row])
    }
}
