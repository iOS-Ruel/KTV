//
//  HomeViewModel.swift
//  KTV
//
//  Created by Chung Wussup on 3/8/24.
//

import Foundation


@MainActor class HomeViewModel {
    private(set) var home: Home?
    let recommendViewModel: HomeRecommendViewModel = .init()
    var dataChanged: (() -> Void)?
    
    func requestData() {
        Task {
            do {
//                let home = try await DataLoader.load(url: URLDefines.home, for: Home.self)
                let home = try DataLoader.load(json: "home", for: Home.self)
                self.home = home
                self.recommendViewModel.recommends = home.recommends
                self.dataChanged?()
            } catch {
                print("json parsing failed: \(error.localizedDescription)")
            }
        }
    }
}
