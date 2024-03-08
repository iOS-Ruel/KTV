//
//  Home.swift
//  KTV
//
//  Created by Chung Wussup on 3/8/24.
//

import Foundation

struct Home: Decodable {
    let videos: [Video]
    let rankings: [Ranking]
    let recents: [Recent]
    let recommends: [Recommend]
}

extension Home {
    
    struct Video: Decodable {
        let videoId: Int
        let isHot: Bool
        let title: String
        let subtitle: String
        let imageUrl: URL
        let channel: String
        let channelThumbnailURL: URL
        let channelDescription: String
    }
    
    struct Ranking: Decodable {
        let imageUrl: URL
        let videoId: Int
        
        enum CodingKeys: CodingKey {
            case imageUrl
            case videoId
        }
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<Home.Ranking.CodingKeys> = try decoder.container(keyedBy: Home.Ranking.CodingKeys.self)
            self.imageUrl = try container.decode(URL.self, forKey: Home.Ranking.CodingKeys.imageUrl)
            self.videoId = try container.decode(Int.self, forKey: Home.Ranking.CodingKeys.videoId)
        }
    }
    
    struct Recent: Decodable {
        let imageUrl: URL
        let timeStamp: Double
        let title: String
        let channel: String
    }
    
    struct Recommend: Decodable {
        let imageUrl: URL
        let title: String
        let playtime: Double
        let channel: String
        let videoId: Int
    }

}

