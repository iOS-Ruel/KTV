//
//  HomeViewController.swift
//  KTV
//
//  Created by Chung Wussup on 3/8/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let homeViewModel: HomeViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.bindViewModel()
        self.homeViewModel.requestData()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {.lightContent}
    
    func setupTableView() {
        self.collectionView.register(
            UINib(nibName:"HomeHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.identifier
        )
        
        self.collectionView.register(
            UINib(nibName:"HomeRankingHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeRankingHeaderView.identifier
        )
        
        self.collectionView.register(
            UINib(nibName:"HomeFooterView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: HomeFooterView.identifier
        )
        
        self.collectionView.register(
            UINib(nibName: "HomeVideoCell", bundle: .main),
            forCellWithReuseIdentifier: HomeVideoCell.identifier
        )
        self.collectionView.register(
            UINib(nibName: "HomeRecommendContainerCell", bundle: .main),
            forCellWithReuseIdentifier: HomeRecommendContainerCell.identifier
        )
//        self.collectionView.register(
//            UINib(nibName: HomeRankingContainerCell.identifier, bundle: nil),
//            forCellWithReuseIdentifier: HomeRankingContainerCell.identifier
//        )
//        self.collectionView.register(
//            UINib(nibName: HomeRecentWatchContainerCell.identifier, bundle: .main),
//            forCellWithReuseIdentifier: HomeRecentWatchContainerCell.identifier
//        )
        self.collectionView.register(UINib(nibName: HomeRankingItemCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeRankingItemCell.identifier)
        self.collectionView.register(UINib(nibName: HomeRecentWatchItemCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeRecentWatchItemCell.identifier)
        
        self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.init(sectionProvider: { [weak self] section, _ in
            self?.makeSection(section)
        })
        
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "empty")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.isHidden = true
    }
    
    private func makeSection(_ section: Int) -> NSCollectionLayoutSection? {
        guard let section = HomeSection(rawValue: section) else {
            return nil
        }
        let itemSpace: CGFloat = 21
        let inset: NSDirectionalEdgeInsets = .init(top: 0, leading: 21, bottom: 21, trailing: 21)
        
        switch section {
        case .header:
            return self.makeHeaderSection()
        case .video:
            return self.makeVideoSection(itemSpace, inset)
        case .ranking:
            return self.makeRankingSection(itemSpace, inset)
        case .recentWatch:
            return self.makeRecentWatchSection(itemSpace, inset)
        case .recommend:
            return self.makeRecommendSection(inset)
        case .footer:
            return self.makeFooterSection()
        }
    }
    
    private func makeHeaderSection() -> NSCollectionLayoutSection{
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(HomeHeaderView.height))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [.init(layoutSize: .init(widthDimension: .absolute(0.1), heightDimension: .absolute(0.1)))])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        
        return section
    }
    
    fileprivate func makeVideoSection(_ itemSpace: CGFloat, _ inset: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection? {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(HomeVideoCell.height))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = inset
        section.interGroupSpacing = itemSpace
        
        return section
    }
    
    fileprivate func makeRankingSection(_ itemSpace: CGFloat, _ inset: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection? {
        let headerLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(HomeRankingHeaderView.height))
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(HomeRankingItemCell.size.width), heightDimension: .absolute(HomeRankingItemCell.size.height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(HomeRankingItemCell.size.width), heightDimension: .absolute(265)), subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = itemSpace
        section.contentInsets = inset
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerLayoutSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        
        return section
    }
    
    fileprivate func makeRecentWatchSection(_ itemSpace: CGFloat, _ inset: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(HomeRecentWatchItemCell.size.width), heightDimension: .absolute(HomeRecentWatchItemCell.size.height))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(HomeRecentWatchItemCell.size.width), heightDimension: .absolute(189)), subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = itemSpace
        section.contentInsets = inset
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    fileprivate func makeRecommendSection(_ inset: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection? {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(HomeRecommendContainerCell.height(viewModel: self.homeViewModel.recommendViewModel)))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = inset
        return section
    }
    
    fileprivate func makeFooterSection() -> NSCollectionLayoutSection? {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(HomeFooterView.height))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [.init(layoutSize: .init(widthDimension: .absolute(0.1), heightDimension: .absolute(0.1)))])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        ]
        return section
    }
    
    private func bindViewModel() {
        self.homeViewModel.dataChanged = { [weak self] in
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
        }
    }
    
    private func presentVideoViewController() {
        if let vc = (self.tabBarController as? VideoViewControllerContrainer)?.videoViewController {
            (self.tabBarController as? VideoViewControllerContrainer)?.presentCurrentViewController()
        } else { 
            let vc = VideoViewController()
            vc.delegate = self.tabBarController as? VideoViewControllerDelegate
            self.present(vc, animated: true)
        }
        
    }
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return
        }
        
        switch section {
        case .header, .footer, .recommend:
            return
        case .video, .ranking, .recentWatch:
            self.presentVideoViewController()
        }
        
    }
    
    
    private func insetForSection(_ section: HomeSection) -> UIEdgeInsets {
        switch section {
        case .header, .footer:
            return .zero
        case .video, .ranking, .recentWatch, .recommend:
            return .init(top: 0, left: 21, bottom: 21, right: 21)
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else {
            return 0
        }
        switch section {
        case .header:
            return 0
        case .video:
            return self.homeViewModel.home?.videos.count ?? 0
        case .ranking:
            return self.homeViewModel.home?.rankings.count ?? 0
        case .recentWatch:
            return self.homeViewModel.home?.recents.count ?? 0
        case .recommend:
            return 1
        case .footer:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return .init()
        }
        switch section {
        case .header:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeaderView.identifier, for: indexPath)
        case .ranking:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeRankingHeaderView.identifier,for: indexPath)
        case .footer:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeFooterView.identifier, for: indexPath)
        case .video, .recentWatch, .recommend:
            return .init()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "empty", for: indexPath)
        }
        
        switch section {
        case .header, .footer:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "empty",
                for: indexPath
            )
        case .video:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeVideoCell.identifier, for: indexPath)
            
            if let cell = cell as? HomeVideoCell,
                let data = self.homeViewModel.home?.videos[indexPath.item] {
                cell.setData(data)
            }
            
            return cell
        case .ranking:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRankingItemCell.identifier, for: indexPath)
            
            if let cell = cell as? HomeRankingItemCell,
               let data = self.homeViewModel.home?.rankings[indexPath.item] {
                cell.setData(data, rank: indexPath.item + 1 )
            }
            
            return cell
        case .recentWatch:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecentWatchItemCell.identifier, for: indexPath)
            
            if let cell = cell as? HomeRecentWatchItemCell,
               let data = self.homeViewModel.home?.recents[indexPath.item] {
                cell.setData(data)
            }
            
            return cell
        case .recommend:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendContainerCell.identifier, for: indexPath)
            
            if let cell = cell as? HomeRecommendContainerCell {
                cell.delegate = self
                cell.setViewModel(self.homeViewModel.recommendViewModel)
            }
            
            return cell
        }
    }
}

extension HomeViewController: HomeRecommendContainerCellDelegate {
    func homeRecommendContainerCellFoldChanged(_ cell: HomeRecommendContainerCell) {
        //레이아웃 사이즈만 다시 계산함
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func homeRecommendContainerCell(_ cell: HomeRecommendContainerCell, didSelectItemAt index: Int) {
        print("home recommend cell did select item at \(index)")
        self.presentVideoViewController()
    }
}

extension HomeViewController: HomeRankingContainerCellDeleate {
    func homeRankingContainerCell(_ cell: HomeRankingContainerCell, didSelectItemAt index: Int) {
        self.presentVideoViewController()
    }
}

extension HomeViewController: HomeRecentWatchContainerCellDelegate {
    
    func homeRecentWatchContainerCell(_ cell: HomeRecentWatchContainerCell, didSelectItemAt index: Int) {
        self.presentVideoViewController()
    }
}
