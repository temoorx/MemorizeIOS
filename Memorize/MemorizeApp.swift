//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Mac on 25/06/2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojisMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(
            viewModel: game)
        }
    }
}
