import UIKit

class WelcomeViewController: UIViewController {
    
    // Predefined topics
    let topics = ["Geography", "Math", "Physics", "Biology"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the title or welcome message
    }
    
    // Action when a topic is selected (connected to buttons in storyboard)
    @IBAction func topicButtonTapped(_ sender: UIButton) {
        // Get the button's title using its configuration (for modern UIButton styles)
        guard let topic = sender.configuration?.title else {
            print("No topic found")
            return
        }
        
        print("Selected topic: \(topic)")
        
        // Navigate to HomeViewController with the selected topic
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeVC = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController {
            homeVC.selectedTopic = topic // Pass the selected topic
            print("Navigating to HomeViewController with topic: \(topic)")
            navigationController?.pushViewController(homeVC, animated: true)
        } else {
            print("Failed to instantiate HomeViewController")
        }
    }
}
