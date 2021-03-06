//
//  UserCell.swift
//  ChatApp
//
//  Created by mac on 23/07/2021.
//

import UIKit
import SDWebImage
import Foundation

class UserCell: UITableViewCell {
    
    //    MARK: - Properties
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.text = "Spiderman"
        return lbl
    }()
    
    private let fullnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        lbl.text = "Peter Parker"
        return lbl
    }()
    
    //    MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 56, width: 56)
        profileImageView.layer.cornerRadius = 56 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Helpers
    
    func configure() {
        usernameLabel.text = self.user?.username
        fullnameLabel.text = self.user?.fullname
        
        guard let imageUrl = URL(string: self.user!.profileImageURL) else { return }
        profileImageView.sd_setImage(with: imageUrl)
    }
}
