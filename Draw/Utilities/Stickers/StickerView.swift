//
//  StickerView.swift
//  Draw
//
//  Created by Tipu Sultan on 4/26/25.
//

import UIKit

class StickerView: UIView {

    private var stickerImageView: UIImageView!
    private var cancelButton: UIButton!
    private var resizeHandle: UIView!

    private(set) var stickerId: UUID = UUID()
    private(set) var imageName: String = ""

    private var initialBounds: CGRect = .zero
    private var initialTouchPoint: CGPoint = .zero

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStickerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStickerView()
    }

    private func setupStickerView() {
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true

        // Sticker image
        stickerImageView = UIImageView(frame: bounds)
        stickerImageView.contentMode = .scaleAspectFit
        stickerImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(stickerImageView)

        // Cancel button
        cancelButton = UIButton(frame: CGRect(x: self.bounds.width - 30, y: 0, width: 30, height: 30))
        cancelButton.setTitle("X", for: .normal)
        cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        cancelButton.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
        addSubview(cancelButton)

        // Pan gesture for moving sticker
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(panGesture)

        // Resize handle view
        resizeHandle = UIView(frame: CGRect(x: bounds.width - 20, y: bounds.height - 20, width: 20, height: 20))
        resizeHandle.backgroundColor = .white
        resizeHandle.layer.borderColor = UIColor.blue.cgColor
        resizeHandle.layer.borderWidth = 2
        resizeHandle.layer.cornerRadius = 10
        resizeHandle.isUserInteractionEnabled = true
        resizeHandle.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        addSubview(resizeHandle)

        let resizePanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleResizePan))
        resizeHandle.addGestureRecognizer(resizePanGesture)
    }

    func configure(with image: UIImage, imageName: String, id: UUID? = nil, saveImageIfNeeded: Bool = false) {
        stickerImageView.image = image
        self.imageName = imageName
        if let existingId = id {
            self.stickerId = existingId
        } else {
            self.stickerId = UUID()
        }

        if saveImageIfNeeded {
            let _ = image.saveToDocuments(fileName: imageName)
        }
    }

    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        gesture.setTranslation(.zero, in: self.superview)

        if gesture.state == .ended {
            saveCurrentStickerState()
        }
    }

    @objc private func handleResizePan(gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: self.superview)

        if gesture.state == .began {
            initialBounds = self.bounds
            initialTouchPoint = touchPoint
        } else if gesture.state == .changed {
            let widthChange = touchPoint.x - initialTouchPoint.x
            let heightChange = touchPoint.y - initialTouchPoint.y
            let newWidth = max(100, initialBounds.width + widthChange)
            let newHeight = max(100, initialBounds.height + heightChange)
            self.bounds = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        } else if gesture.state == .ended {
            saveCurrentStickerState()
        }
    }

    @objc private func handleCancel() {
        StickerDataCRUD.shared.deleteSticker(withId: stickerId)
        deleteImageFromDocuments()
        self.removeFromSuperview()
    }

    private func deleteImageFromDocuments() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(imageName)
        try? FileManager.default.removeItem(at: url)
    }

    func generateStickerData() -> StickerData {
        return StickerData(
            id: stickerId,
            centerX: center.x,
            centerY: center.y,
            width: frame.size.width,
            height: frame.size.height,
            imageName: imageName
        )
    }

    private func saveCurrentStickerState() {
        var stickers = StickerDataCRUD.shared.fetchStickers()
        if let index = stickers.firstIndex(where: { $0.id == stickerId }) {
            stickers[index] = generateStickerData()
            StickerDataCRUD.shared.overwriteStickers(stickers)
        }
    }
}



