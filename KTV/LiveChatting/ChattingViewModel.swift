//
//  ChattingViewModel.swift
//  KTV
//
//  Created by Chung Wussup on 3/12/24.
//

import Foundation

@MainActor class ChattingViewModel {

    private let chattingSimulator = ChatSimulator()
    var chatReceived: (() -> Void)?
    private(set) var messages: [ChatMessage] = []
    
    init() {
        self.chattingSimulator.setMessageHandler { [weak self] in
            self?.messages.append($0)
            self?.chatReceived?()
        }
    }
    
    func start() {
        self.chattingSimulator.start()
    }
    
    func stop() {
        self.chattingSimulator.stop()
    }
    
    
    func sendMessage(_ message: String) {
        self.chattingSimulator.sendMessage(message)
    }
    
}

