//
//  ConversationsCell.swift
//  ChatApp
//
//  Created by mac on 31/07/2021.
//

import UIKit

class ConversationCell: UITableViewCell {
    
    //  MARK: - Properties
    
    var conversation: Conversation? {
        didSet {
            configure()
        }
    }
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
       return iv
    }()
    
    private let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()

    private let timestampLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    //  MARK: - Lifecycle
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, messageLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
        
        addSubview(timestampLabel)
        timestampLabel.anchor(top: stack.topAnchor, left: stack.rightAnchor, right: rightAnchor, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Helpers
    
    func configure() {
        usernameLabel.text = conversation?.user.username
        messageLabel.text = conversation?.message.text
//        timestampLabel.text = conversation?.message.timestamp
//        guard let imageUrl = URL(string: conversation!.user.profileImageURL) else { return }
//        profileImageView.sd_setImage(with: imageUrl)
    }
}


