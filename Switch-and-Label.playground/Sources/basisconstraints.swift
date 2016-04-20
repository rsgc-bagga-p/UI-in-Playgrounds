import Foundation

/*
 
 ericasadun.com
 Super-basic priority-less layout utilities
 
 */

#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif

// UIKit/Cocoa Classes
#if os(OSX)
    public typealias View = NSView
    public typealias Font = NSFont
    public typealias Color = NSColor
    public typealias Image = NSImage
    public typealias BezierPath = NSBezierPath
    public typealias ViewController = NSViewController
#else
    public typealias View = UIView
    public typealias Font = UIFont
    public typealias Color = UIColor
    public typealias Image = UIImage
    public typealias BezierPath = UIBezierPath
    public typealias ViewController = UIViewController
#endif

let DefaultLayoutOptions: NSLayoutFormatOptions = []

#if !os(OSX)
    /// Stretch view to the edges of the parent view controller
    public func StretchViewToViewController(viewController: ViewController, view: View, insets: CGSize) {
        view.translatesAutoresizingMaskIntoConstraints = false
        if view.superview == nil {viewController.view.addSubview(view)}
        
        let topGuide = viewController.topLayoutGuide
        let bottomGuide = viewController.bottomLayoutGuide
        let bindings: [String: AnyObject] = [
            "topGuide": topGuide,
            "bottomGuide": bottomGuide,
            "view": view]
        let metrics: [String: AnyObject] = [
            "hInset": insets.width,
            "vInset": insets.height
        ]
        
        for format: String in [
            "H:|-hInset-[view]-hInset-|",
            "V:[topGuide]-vInset-[view]-vInset-[bottomGuide]"
            ] {
                let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: DefaultLayoutOptions, metrics: metrics, views: bindings)
                NSLayoutConstraint.activateConstraints(constraints)
        }
    }
#endif

/// Stretch view to superview
public func StretchViewToSuperview(view: View, horizontal: Bool, vertical: Bool) {
    view.translatesAutoresizingMaskIntoConstraints = false
    if horizontal {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["view":view])
        NSLayoutConstraint.activateConstraints(constraints)
    }
    if vertical {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["view": view])
        NSLayoutConstraint.activateConstraints(constraints)
    }
}

/// Center view in superview
public func CenterViewInSuperview(view: View, horizontal: Bool, vertical: Bool) {
    view.translatesAutoresizingMaskIntoConstraints = false
    var c: NSLayoutConstraint
    if vertical {
        c = NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: view.superview, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        c.active = true
    }
    
    if horizontal {
        c = NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: view.superview, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        c.active = true
    }
}

/// Constraint view
public func ConstrainViews(format: String, views: View...) {
    guard !views.isEmpty else {return}
    guard let firstView = views.first else {return}
    var bindings: [String: View] = ["view": firstView]
    var i = 1
    for view in views {
        bindings["view"+String(i)] = view; i += 1
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings)
    NSLayoutConstraint.activateConstraints(constraints)
}

public func ConstrainView(format: String, view: View) {
    ConstrainViews(format, views: view)
}