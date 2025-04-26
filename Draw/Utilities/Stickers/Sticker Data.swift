//
//  Sticker Data.swift
//  Draw
//
//  Created by Tipu Sultan on 4/26/25.
//

import UIKit
import Foundation



class StickerDataCRUD {
    static let shared = StickerDataCRUD()
    
    private let key = "saved_stickers"
    
    private init() {}
    
    func saveSticker(_ sticker: StickerData) {
        var stickers = fetchStickers()
        stickers.append(sticker)
        save(stickers)
    }
    
    func overwriteStickers(_ stickers: [StickerData]) {
        save(stickers)
    }
    
    func fetchStickers() -> [StickerData] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let stickers = try? JSONDecoder().decode([StickerData].self, from: data) else {
            return []
        }
        return stickers
    }
    
    func deleteSticker(withId id: UUID) {
        var stickers = fetchStickers()
        stickers.removeAll { $0.id == id }
        save(stickers)
    }
    
    private func save(_ stickers: [StickerData]) {
        if let data = try? JSONEncoder().encode(stickers) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

