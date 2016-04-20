/*:
# Recall
 
Common application design pattern is MVC: model, view, controller.

* **Model**: holds data, does not know about the user interface
* **View**: objects that are visible to the user; the user interface
* **Controller**: "application manager"; keeps view layer & model layer in sync

In this playground, we are going to embed two views as subviews of a "live view" in a playground page

This will allow us to experiment with creating view objects in a playground, saving us from starting
a new project in Xcode every time we want to try out a view object
*/
import UIKit
import XCPlayground

// First, we will define a custom view controller named ViewController that
// is a sub-class of UIViewController
class ViewController : UIViewController {
    
    
    override func viewDidLoad() {
        
        // Sub-classes of UIViewController must invoke the superclass method viewDidLoad in their
        // own version of viewDidLoad()
        super.viewDidLoad()
        
    }
    
} // end of class ViewController

// Create an instance of the ViewController class
ViewController()

// Embed the view controller in the live view for the current playground page
XCPlaygroundPage.currentPage.liveView = ViewController()
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true