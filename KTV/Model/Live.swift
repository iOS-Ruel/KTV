//
//  Live.swift
//  KTV
//
//  Created by Chung Wussup on 3/12/24.
//

import Foundation


struct Live: Decodable {
    let list: [Item]
}

extension Live {
    struct Item: Decodable {
        let videoId: Int
        let thumbnailUrl: URL
        let title: String
        let channel: String
    }
}
