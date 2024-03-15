//
//  VideoViewControllerContrainer.swift
//  KTV
//
//  Created by Chung Wussup on 3/15/24.
//

import Foundation


protocol VideoViewControllerContrainer {
    var videoViewController: VideoViewController? { get }
    func presentCurrentViewController()
}
