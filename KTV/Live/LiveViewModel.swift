//
//  LiveViewModel.swift
//  KTV
//
//  Created by Chung Wussup on 3/12/24.
//

import Foundation

enum LiveSortOption {
    case favorite
    case start
}

@MainActor class LiveVieWMore {
    private(set) var items: [Live.Item]?
    private(set) var sortOption: LiveSortOption = .favorite
    var dataChanged: (([Live.Item]) -> Void)?
    
    func request(sort: LiveSortOption) {
        Task{
            do {
                let live = try await DataLoader.load(url: URLDefines.live, for: Live.self)
                let itmes: [Live.Item]
                if sort == .start {
                    itmes = live.list.reversed()
                } else {
                    itmes = live.list
                }
                self.items = itmes
                self.dataChanged?(itmes)
            } catch {
                print("Live data Load Failed")
            }
        }
    }
    
    
}
