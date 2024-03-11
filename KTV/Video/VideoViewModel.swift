//
//  VideoViewModel.swift
//  KTV
//
//  Created by Chung Wussup on 3/11/24.
//

import Foundation

@MainActor class VideoViewModel {
    
    private(set) var video: Video?
    var dataChangeHandler: ((Video) -> Void)?
    
    func request() {
        Task {
            do {
                let video = try await DataLoader.load(url: URLDefines.video, for: Video.self)
                self.video = video
                self.dataChangeHandler?(video)
            } catch {
                print("video load did failed \(error.localizedDescription)")
            }
            
        }
    }
}
