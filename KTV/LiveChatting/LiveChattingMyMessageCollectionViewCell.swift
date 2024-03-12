//
//  LiveChattingMyMessageCollectionViewCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/02.
//

import UIKit

class LiveChattingMyMessageCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "LiveChattingMyMessageCollectionViewCell"
    
    private static let sizingCell = Bundle.main.loadNibNamed(
        "LiveChattingMyMessageCollectionViewCell",
        owner: nil
    )?.first(where: { $0 is LiveChattingMyMessageCollectionViewCell }) as? LiveChattingMyMessageCollectionViewCell

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    static func size(width: CGFloat, text: String) -> CGSize {
        // 텍스트의 경우 사이즈가 고정적이지 않기 때문에 계산이 필요함
        // 다이나믹한 사이즈를 구할 때는 Bundle에 Nib파일을 하나 만들어 로드를 시킴 -> 원하는 사이즈를 계산하기 위한 사이즈 셀임
        
        // 텍스트를 넣어주고 가로 사이즈를 맞춰줌
        // AutoLayout 엔진을 활용하여 레이아웃을 계산함
        // systemLayoutSizeFitting 메서드를 사용하면 오토레이아웃이 정확하게 잡혀잇다면
        // 오토레이아웃상황에 맞춰 사이즈를 계산해줌
         
        // 기대되는 사이즈를 구할 수 있지만 레이아웃 엔진을 매번 실행하는게 좋은 효율과 성능을 내지 못한다.
        
        Self.sizingCell?.setText(text)
        Self.sizingCell?.frame.size.width = width
        let fittingSize = Self.sizingCell?.systemLayoutSizeFitting(
            .init(width: width, height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return fittingSize ?? .zero
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgView.layer.cornerRadius = 8
    }
    
    func setText(_ text: String) {
        self.textLabel.text = text
    }

}
