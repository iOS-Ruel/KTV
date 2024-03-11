//
//  MyViewController.swift
//  KTV
//
//  Created by Chung Wussup on 3/11/24.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileImageView.layer.cornerRadius = 5
    }
    

    @IBAction func bookmarkDidTap(_ sender: Any) {
    }
    
    
    @IBAction func favoriteDidTap(_ sender: Any) {
        self.performSegue(withIdentifier: "favorite", sender: nil)
    }
}
