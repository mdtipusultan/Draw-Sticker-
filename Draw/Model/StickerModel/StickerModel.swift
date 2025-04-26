//
//  StickerModel.swift
//  Draw
//
//  Created by Tipu Sultan on 4/26/25.
//

import Foundation

struct StickerData: Codable {
    var id: UUID
    var centerX: CGFloat
    var centerY: CGFloat
    var width: CGFloat
    var height: CGFloat
    var imageName: String
}
