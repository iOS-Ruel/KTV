//
//  VideoListItem.swift
//  KTV
//
//  Created by Chung Wussup on 3/11/24.
//

import Foundation

struct VideoListItem: Decodable {
    let imageUrl: URL
    let title: String
    let playtime: Double
    let channel: String
    let videoId: Int
}
