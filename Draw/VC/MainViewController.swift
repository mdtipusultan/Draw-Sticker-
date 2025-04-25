////
////  MainViewController.swift
////  Draw
////
////  Created by Tipu Sultan on 4/25/25.
////
//
//import UIKit
//
//class MainViewController: UIViewController, DrawingViewControllerDelegate {
//
//    @IBOutlet weak var drawingImageView: UIImageView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Home"
//        drawingImageView.contentMode = .scaleAspectFit
//        drawingImageView.backgroundColor = .secondarySystemBackground
//    }
//
//    @IBAction func openDrawingScreen(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let vc = storyboard.instantiateViewController(withIdentifier: "DrawingViewController") as? DrawingViewController {
//            vc.delegate = self
//            let nav = UINavigationController(rootViewController: vc)
//            present(nav, animated: true)
//        }
//    }
//
//    func didFinishDrawing(image: UIImage) {
//        drawingImageView.image = image
//    }
//}


import UIKit

class MainViewController: UIViewController, DrawingViewControllerDelegate {

    
    @IBOutlet weak var containerView: UIView! // Container for stickers

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        containerView.backgroundColor = .secondarySystemBackground
    }

    @IBAction func openDrawingScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DrawingViewController") as? DrawingViewController {
            vc.delegate = self
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        }
    }

    func didFinishDrawing(image: UIImage) {
        // Create a sticker view with the drawn image
        let stickerView = StickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        stickerView.center = containerView.center
        stickerView.configure(with: image)
        containerView.addSubview(stickerView)
    }
}

import UIKit

class StickerView: UIView {
    private var imageView: UIImageView!
    private var lastLocation = CGPoint.zero

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Add an image view to display the sticker image
        imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)

        // Add gesture recognizers
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGesture)

        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        addGestureRecognizer(pinchGesture)

        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        addGestureRecognizer(rotationGesture)

        isUserInteractionEnabled = true
    }

    func configure(with image: UIImage) {
        imageView.image = image
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        switch gesture.state {
        case .began:
            lastLocation = center
        case .changed:
            center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
        default:
            break
        }
    }

    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard gesture.state == .changed else { return }
        transform = transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1.0
    }

    @objc private func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        guard gesture.state == .changed else { return }
        transform = transform.rotated(by: gesture.rotation)
        gesture.rotation = 0.0
    }
}
