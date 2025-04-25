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
//    private let drawingImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .secondarySystemBackground
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Home"
//        view.backgroundColor = .systemBackground
//
//        let drawButton = UIButton(type: .system)
//        drawButton.setTitle("Draw", for: .normal)
//        drawButton.addTarget(self, action: #selector(openDrawingScreen), for: .touchUpInside)
//        drawButton.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(drawButton)
//        view.addSubview(drawingImageView)
//
//        NSLayoutConstraint.activate([
//            drawButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            drawButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//
//            drawingImageView.topAnchor.constraint(equalTo: drawButton.bottomAnchor, constant: 20),
//            drawingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            drawingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            drawingImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//    }
//
//    @objc private func openDrawingScreen() {
//        let vc = DrawingViewController()
//        vc.delegate = self
//       // navigationController?.pushViewController(vc, animated: true)
//                let navController = UINavigationController(rootViewController: vc)
//                present(navController, animated: true, completion: nil)
//    }
//
//    func didFinishDrawing(image: UIImage) {
//        drawingImageView.image = image
//    }
//}



import UIKit

class MainViewController: UIViewController, DrawingViewControllerDelegate {

    @IBOutlet weak var drawingImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        drawingImageView.contentMode = .scaleAspectFit
        drawingImageView.backgroundColor = .secondarySystemBackground
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
        drawingImageView.image = image
    }
}
