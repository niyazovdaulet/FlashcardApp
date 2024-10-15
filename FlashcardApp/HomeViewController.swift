//
//  HomeViewController.swift
//  FlashcardApp
//
//  Created by Daulet on 04/10/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var flashcardLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var selectedTopic: String? // Topic passed from WelcomeViewController
    var flashcards: [(question: String, answer: String)] = [] // Flashcards with question-answer pairs
    var currentIndex = 0 // Index for current flashcard
    var isShowingQuestion = true // To track if we're showing the question or answer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the navigation title to the selected topic
        self.title = selectedTopic ?? "Flashcards"
        
        // Load the flashcards based on the selected topic
        loadFlashcards(for: selectedTopic ?? "Geography")
        
        // Add tap gesture recognizer for flipping the flashcard
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnFlashcard))
        flashcardLabel.addGestureRecognizer(tapGestureRecognizer)
        flashcardLabel.isUserInteractionEnabled = true
        
        // Display the first flashcard
        updateFlashcard()
    }
    
    func loadFlashcards(for topic: String) {
        switch topic {
        case "Geography":
            flashcards = [("What is the capital of France?", "Paris"),
                          ("What is the largest ocean?", "Pacific Ocean"),
                          ("What continent is Egypt in?", "Africa")]
        case "Math":
            flashcards = [("What is 2 + 2?", "4"),
                          ("What is the square root of 16?", "4"),
                          ("What is 10 x 10?", "100")]
        case "Physics":
            flashcards = [("What is Newton's second law?", "F = ma"),
                          ("What is the speed of light?", "299,792,458 m/s"),
                          ("What is gravity?", "9.8 m/s²")]
        case "Biology":
            flashcards = [("What is photosynthesis?", "Process by which plants make food"),
                          ("What is the human heart?", "An organ that pumps blood"),
                          ("What is DNA?", "Deoxyribonucleic acid")]
        default:
            flashcards = []
        }
    }
    
    func updateFlashcard() {
        guard !flashcards.isEmpty else {
            flashcardLabel.text = "No Flashcards available."
            return
        }
        
        // Show the question initially
        flashcardLabel.text = flashcards[currentIndex].question
        isShowingQuestion = true
    }
    
    @IBAction func nextFlashcard(_ sender: UIButton) {
        currentIndex = (currentIndex + 1) % flashcards.count
        updateFlashcard()
    }

    @IBAction func prevFlashcard(_ sender: UIButton) {
        currentIndex = (currentIndex - 1 + flashcards.count) % flashcards.count
        updateFlashcard()
    }
    
    @objc func didTapOnFlashcard() {
        // Flip animation
        UIView.transition(with: flashcardLabel, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if self.isShowingQuestion {
                self.flashcardLabel.text = self.flashcards[self.currentIndex].answer
            } else {
                self.flashcardLabel.text = self.flashcards[self.currentIndex].question
            }
        }, completion: nil)
        
        // Toggle between showing question and answer
        isShowingQuestion.toggle()
    }
}
