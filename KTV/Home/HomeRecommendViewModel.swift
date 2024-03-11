//
//  HomeRecommendViewModel.swift
//  KTV
//
//  Created by Chung Wussup on 3/8/24.
//

import Foundation


class HomeRecommendViewModel {
    private(set) var isFolded: Bool = true {
        didSet {
            self.foldChanged?(self.isFolded)
        }
    }
    
    var foldChanged:((Bool) -> Void)?
    
    var recommends: [VideoListItem]?
    var itemCount: Int {
        let count = self.isFolded ? 5 : self.recommends?.count ?? 0
        print("min : ", min(self.recommends?.count ?? 0, count))
        return min(self.recommends?.count ?? 0, count)
    }
    
    func toggleFoldState() {
        self.isFolded.toggle()
    }
}
