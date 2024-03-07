//
//  HomeVideoCell.swift
//  KTV
//
//  Created by Chung Wussup on 3/8/24.
//

import UIKit

class HomeVideoCell: UITableViewCell {
    static let identifier = "HomeVideoCell"
    static let height: CGFloat = 320
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var hotImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelSubTitleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 20
        self.containerView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        self.containerView.layer.borderWidth = 1
//        self.containerView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
