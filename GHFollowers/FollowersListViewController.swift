//
//  FollowersListViewController.swift
//  GHFollowers
//
//  Created by Luiz Felipe on 19/10/25.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden =  false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
