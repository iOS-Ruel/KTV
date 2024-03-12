//
//  ChattingView.swift
//  KTV
//
//  Created by Chung Wussup on 3/12/24.
//

import UIKit

protocol ChattingViewDelegate: AnyObject {
    func liveChattingViewCloseDidTap(_ chattingView: ChattingView)
}

class ChattingView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textfield: UITextField!
    
    
    weak var delegate: ChattingViewDelegate?
    
    private let viewModel: ChattingViewModel = ChattingViewModel()
    
    override var isHidden: Bool {
        didSet {
            self.toggleViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupCollectionView()
        self.setupTextField()
        self.toggleViewModel()
        self.bindViewModel()
    }
    
    deinit {
        
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.textfield.resignFirstResponder()
    }
    
    @IBAction func closeDidTap(_ sender: Any) {
        self.textfield.resignFirstResponder()
        self.delegate?.liveChattingViewCloseDidTap(self)
    }
    
    private func bindViewModel() {
        self.viewModel.chatReceived = { [weak self] in
            self?.collectionView.reloadData()
            self?.scrollToLatestIfNeeded()
        }
    }
    
    private func toggleViewModel(){
        print(self.isHidden)
        if self.isHidden {
            print("stop")
            self.viewModel.stop()
        } else {
            print("start")
            self.viewModel.start()
        }
    }
    
    private func scrollToLatestIfNeeded() {
        // bounds를 이용하면 collectionView가 보이는 위치를 알 수 있음
        //maxY는 보이는 제일 하단을 알 수 있음
        
        //self.collectionView.contentSize.height보다 같거나 크면 스크롤이 가장 하단인 상태임
        let isBottomOffset = self.collectionView.bounds.maxY >= self.collectionView.contentSize.height - 200
        //내가 보낸 메세지가 가장 마지막일 때 제일 하단으로 보내야함
        let isLastMessageMine = self.viewModel.messages.last?.isMine == true
        
        
        if isBottomOffset || isLastMessageMine {
            self.collectionView.scrollToItem(at: IndexPath(item: self.viewModel.messages.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    private func setupTextField() {
        self.textfield.delegate = self
        self.textfield.attributedPlaceholder = NSAttributedString(string: "채팅에 참여해보세요",
                                                                  attributes: [.foregroundColor: UIColor(named: "chat-text") ?? .clear, .font: UIFont.systemFont(ofSize: 12,weight: .medium)])
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: LiveChattingMessageCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: LiveChattingMessageCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: LiveChattingMyMessageCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: LiveChattingMyMessageCollectionViewCell.identifier)
    }

}

extension ChattingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.viewModel.messages[indexPath.item]
        let width = collectionView.frame.width - 32
        
        if item.isMine {
            return LiveChattingMyMessageCollectionViewCell.size(width: width, text: item.text)
        } else {
            return LiveChattingMessageCollectionViewCell.size(width: width, text: item.text)
        }
        
        
    }
}
extension ChattingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.messages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.viewModel.messages[indexPath.row]
        
        if item.isMine {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveChattingMyMessageCollectionViewCell.identifier, for: indexPath)
            
            if let cell = cell as? LiveChattingMyMessageCollectionViewCell {
                cell.setText(item.text)
            }
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveChattingMessageCollectionViewCell.identifier, for: indexPath)
            
            if let cell = cell as? LiveChattingMessageCollectionViewCell {
                cell.setText(item.text)
            }
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension ChattingView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        
        self.viewModel.sendMessage(text)
        textField.text = nil
        
        return true
    }
}
