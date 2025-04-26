////
////  MainViewController.swift
////  Draw
////
////  Created by Tipu Sultan on 4/25/25.
////
//
//
//import UIKit
//import Drawsana
//
//class MainViewController: UIViewController, DrawingViewControllerDelegate {
//
//    
//    @IBOutlet weak var containerView: UIView! // Container for stickers
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Home"
//        containerView.backgroundColor = .secondarySystemBackground
//    }
//
//    @IBAction func openDrawingScreen(_ sender: UIButton) {
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        if let vc = storyboard.instantiateViewController(withIdentifier: "DrawingViewController") as? DrawingViewController {
////            vc.delegate = self
////            let nav = UINavigationController(rootViewController: vc)
////            
////            present(nav, animated: true)
////        }
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//          if let vc = storyboard.instantiateViewController(withIdentifier: "DrawingViewController") as? DrawingViewController {
//              vc.delegate = self
//              navigationController?.pushViewController(vc, animated: true)
//          }
//    }
//
//    func didFinishDrawing(image: UIImage) {
//        // Create a sticker view with the drawn image
//        let stickerView = StickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        stickerView.center = containerView.center
//        stickerView.configure(with: image)
//        containerView.addSubview(stickerView)
//    }
//}
//
////import UIKit
////
////class StickerView: UIView {
////    private var imageView: UIImageView!
////    private var lastLocation = CGPoint.zero
////
////    override init(frame: CGRect) {
////        super.init(frame: frame)
////        setupView()
////    }
////
////    required init?(coder: NSCoder) {
////        super.init(coder: coder)
////        setupView()
////    }
////
////    private func setupView() {
////        // Add an image view to display the sticker image
////        imageView = UIImageView(frame: bounds)
////        imageView.contentMode = .scaleAspectFit
////        addSubview(imageView)
////
////        // Add gesture recognizers
////        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
////        addGestureRecognizer(panGesture)
////
////        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
////        addGestureRecognizer(pinchGesture)
////
////        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
////        addGestureRecognizer(rotationGesture)
////
////        isUserInteractionEnabled = true
////    }
////
////    func configure(with image: UIImage) {
////        imageView.image = image
////    }
////
////    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
////        let translation = gesture.translation(in: self.superview)
////        switch gesture.state {
////        case .began:
////            lastLocation = center
////        case .changed:
////            center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
////        default:
////            break
////        }
////    }
////
////    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
////        guard gesture.state == .changed else { return }
////        transform = transform.scaledBy(x: gesture.scale, y: gesture.scale)
////        gesture.scale = 1.0
////    }
////
////    @objc private func handleRotation(_ gesture: UIRotationGestureRecognizer) {
////        guard gesture.state == .changed else { return }
////        transform = transform.rotated(by: gesture.rotation)
////        gesture.rotation = 0.0
////    }
////}
////
////
////
//
//
//import UIKit
//import Drawsana
//
//class StickerView: UIView {
//    private var imageView: UIImageView!
//    private var lastLocation = CGPoint.zero
//    private var cancelButton: UIButton!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//
//    private func setupView() {
//        // Add an image view to display the sticker image
//        imageView = UIImageView(frame: bounds)
//        imageView.contentMode = .scaleAspectFit
//        addSubview(imageView)
//
//        // Add gesture recognizers
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//        addGestureRecognizer(panGesture)
//
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
//        addGestureRecognizer(pinchGesture)
//
//        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
//        addGestureRecognizer(rotationGesture)
//
//        // Add a cancel button (cross button) using Drawsana's cross-border
//        cancelButton = UIButton(type: .system)
//        cancelButton.frame = CGRect(x: bounds.width - 40, y: -20, width: 40, height: 40)
//        cancelButton.setTitle("✖️", for: .normal)
//        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
//        cancelButton.addTarget(self, action: #selector(handleCancel(_:)), for: .touchUpInside)
//        addSubview(cancelButton)
//
//        isUserInteractionEnabled = true
//    }
//
//    func configure(with image: UIImage) {
//        imageView.image = image
//    }
//
//    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: self.superview)
//        switch gesture.state {
//        case .began:
//            lastLocation = center
//        case .changed:
//            center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
//        default:
//            break
//        }
//    }
//
//    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
//        guard gesture.state == .changed else { return }
//        transform = transform.scaledBy(x: gesture.scale, y: gesture.scale)
//        gesture.scale = 1.0
//    }
//
//    @objc private func handleRotation(_ gesture: UIRotationGestureRecognizer) {
//        guard gesture.state == .changed else { return }
//        transform = transform.rotated(by: gesture.rotation)
//        gesture.rotation = 0.0
//    }
//
//    @objc private func handleCancel(_ gesture: UIButton) {
//        // When the cancel button is pressed, remove the sticker
//        self.removeFromSuperview()
//    }
//}


import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        containerView.backgroundColor = .secondarySystemBackground
        loadSavedStickers()
    }
    
    @IBAction func openDrawingScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DrawingViewController") as? DrawingViewController {
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func loadSavedStickers() {
        let savedStickers = StickerDataCRUD.shared.fetchStickers()
        
        for stickerData in savedStickers {
            let stickerView = StickerView(frame: CGRect(x: 0, y: 0, width: stickerData.width, height: stickerData.height))
            stickerView.center = CGPoint(x: stickerData.centerX, y: stickerData.centerY)
            
            if let savedImage = UIImage.loadFromDocuments(fileName: stickerData.imageName) {
                stickerView.configure(with: savedImage, imageName: stickerData.imageName, id: stickerData.id)
            } else if let fallbackImage = UIImage(named: stickerData.imageName) {
                stickerView.configure(with: fallbackImage, imageName: stickerData.imageName, id: stickerData.id)
            }
            
            containerView.addSubview(stickerView)
        }
    }
}


extension MainViewController: DrawingViewControllerDelegate {
    func didFinishDrawing(image: UIImage) {
        let uniqueImageName = "user_drawn_sticker_\(UUID().uuidString).png"
        
        let stickerView = StickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        stickerView.center = containerView.center
        stickerView.configure(with: image, imageName: uniqueImageName, saveImageIfNeeded: true)
        containerView.addSubview(stickerView)
        
        let stickerData = stickerView.generateStickerData()
        StickerDataCRUD.shared.saveSticker(stickerData)
    }
}


extension UIImage {
    func saveToDocuments(fileName: String) -> Bool {
        guard let data = self.pngData() else { return false }
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
        
        do {
            try data.write(to: url)
            return true
        } catch {
            print("Failed to save image:", error)
            return false
        }
    }
    
    static func loadFromDocuments(fileName: String) -> UIImage? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
        
        return UIImage(contentsOfFile: url.path)
    }
}


