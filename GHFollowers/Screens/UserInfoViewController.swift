//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Luiz Felipe on 14/01/26.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    let headerViewController = UIView()
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let doneButton  = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        
        layoutUI()

        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self]  result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(child: UserInfoHeaderViewController(user: user), to: self.headerViewController)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Somenthing went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        })
    }
    
    func layoutUI() {
        view.addSubview(headerViewController)
        
        headerViewController.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            headerViewController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerViewController.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func add(child: UIViewController, to containerView: UIView) {
          addChild(child)
           containerView.addSubview(child.view)
           
           child.view.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               child.view.topAnchor.constraint(equalTo: containerView.topAnchor),
               child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
               child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
               child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
           ])
           
           child.didMove(toParent: self)
    }
    
     @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
