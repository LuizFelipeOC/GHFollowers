//
//  FollowersListViewController.swift
//  GHFollowers
//
//  Created by Luiz Felipe on 19/10/25.
//



import UIKit



class FollowersListViewController: UIViewController {
    
    
    enum Section: Hashable, Sendable {
        case main
    }

    
    var username: String!
    var followers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var page = 1
    var hasMoreFollowers = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController();
        configureColletionView()
        getFollowers(username: username, page: page)
        configureDataSoruce()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    
    func configureColletionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureDataSoruce() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {(collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.sync {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
  
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            
            self.dimissLoadingView()
                
            switch result {
            case .success(let followers):
               
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        let message         = "This user does not have any followers."
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                
                
                self.updateData()
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowersListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY                = scrollView.contentOffset.y
        let contentHeight         = scrollView.contentSize.height
        let height                = scrollView.frame.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
}
