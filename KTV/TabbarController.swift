//
//  TabbarController.swift
//  KTV
//
//  Created by Chung Wussup on 3/8/24.
//

import UIKit

class TabbarController: UITabBarController,VideoViewControllerContrainer, VideoViewControllerDelegate {
  
    
    weak var videoViewController: VideoViewController?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func videoViewController(_ videoViewController: VideoViewController, yPositionForMinimizeView height: CGFloat) -> CGFloat {
        return self.tabBar.frame.minY - height
    }
    
    func videoViewControllerDidMinimize(_ videoViewController: VideoViewController) {
        self.videoViewController = videoViewController
        self.addChild(videoViewController)
        self.view.addSubview(videoViewController.view)
        videoViewController.didMove(toParent: self)
    }
    
    func videoViewControllerNeedsMaximize(_ videoViewController: VideoViewController) {
        self.videoViewController = nil
        videoViewController.willMove(toParent: nil)
        videoViewController.view.removeFromSuperview()
        videoViewController.removeFromParent()
        
        self.present(videoViewController, animated: true)
    }
    
    func videoViewControllerDidTapClose(_ videoViewController: VideoViewController) {
        videoViewController.willMove(toParent: nil)
        videoViewController.view.removeFromSuperview()
        videoViewController.removeFromParent()
        
        self.videoViewController = nil
    }
    
    func presentCurrentViewController() {
        guard let videoViewController else { return }
        videoViewController.willMove(toParent: nil)
        videoViewController.view.removeFromSuperview()
        videoViewController.removeFromParent()
        
        self.present(videoViewController, animated: true)
        self.videoViewController = nil
    }
}
