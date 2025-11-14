//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Luiz Felipe on 13/11/25.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userName = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        userName.text = follower.login
        avatarImageView.downLoadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(userName)
        
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            userName.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            userName.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
