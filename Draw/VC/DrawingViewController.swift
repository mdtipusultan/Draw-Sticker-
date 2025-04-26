//
//  DrawingViewController.swift
//  Draw
//
//  Created by Tipu Sultan on 4/25/25.
//

import UIKit
import PencilKit

protocol DrawingViewControllerDelegate: AnyObject {
    func didFinishDrawing(image: UIImage)
}

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var canvasView: PKCanvasView!
    
    weak var delegate: DrawingViewControllerDelegate?
    
    private let toolPicker = PKToolPicker()
    private var undoStack: [PKStroke] = [] // Store individual strokes for undo
    private var redoStack: [PKStroke] = [] // Store individual strokes for redo
    
    // Flag to track programmatic changes
    private var isProgrammaticChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Freehand Sketch"
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = self
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.bounces = true
        canvasView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let window = view.window {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            canvasView.becomeFirstResponder()
        }
    }
    
    
    @IBAction func cancelDrawing(_ sender: UIBarButtonItem) {
       // dismiss(animated: true)
        
        // Navigate back to the previous screen
           navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveDrawing(_ sender: UIBarButtonItem) {
//        let scale = UIScreen.main.scale
//        let image = canvasView.drawing.image(from: canvasView.bounds, scale: scale)
//        delegate?.didFinishDrawing(image: image)
//        dismiss(animated: true)
        
        
        // Capture the drawing as an image
           let scale = UIScreen.main.scale
           let image = canvasView.drawing.image(from: canvasView.bounds, scale: scale)
           
           // Notify the delegate with the captured image
           delegate?.didFinishDrawing(image: image)
           
           // Navigate back to the previous screen
           navigationController?.popViewController(animated: true)
    }
    
    @IBAction func undoActions(_ sender: UIButton) {
        guard !undoStack.isEmpty else { return }
        
        // Mark as programmatic change
        isProgrammaticChange = true
        
        // Save the last stroke to the redo stack
        if let lastStroke = canvasView.drawing.strokes.last {
            redoStack.append(lastStroke)
            undoStack.removeLast()
            
            // Remove the last stroke from the canvas
            var updatedDrawing = canvasView.drawing
            updatedDrawing.strokes.removeLast()
            canvasView.drawing = updatedDrawing
        }
        
        // Reset the flag
        isProgrammaticChange = false
    }
    
    @IBAction func redoActions(_ sender: UIButton) {
        guard !redoStack.isEmpty else { return }
        
        // Mark as programmatic change
        isProgrammaticChange = true
        
        // Restore the next stroke from the redo stack
        let nextStroke = redoStack.removeLast()
        undoStack.append(nextStroke)
        
        // Add the stroke back to the canvas
        var updatedDrawing = canvasView.drawing
        updatedDrawing.strokes.append(nextStroke)
        canvasView.drawing = updatedDrawing
        
        // Reset the flag
        isProgrammaticChange = false
    }
}

// MARK: - PKCanvasViewDelegate
extension DrawingViewController: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        // Ignore changes caused by undo/redo actions
        guard !isProgrammaticChange else { return }
        
        // Append the latest stroke to the undo stack
        if let lastStroke = canvasView.drawing.strokes.last {
            undoStack.append(lastStroke)
        }
        
        // Clear the redo stack when a new stroke is made
        redoStack.removeAll()
    }
}

// MARK: - UIScrollViewDelegate
extension DrawingViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return canvasView
    }
}
