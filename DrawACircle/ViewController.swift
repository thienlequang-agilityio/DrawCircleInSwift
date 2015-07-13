//
//  ViewController.swift
//  DrawACircle
//
//  Created by Christian Hagel-Sorensen on 1/18/15.
//  Copyright (c) 2015 Christian Hagel-Sorensen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TheViewForTheCircle: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var AddQuarterCircleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalizeCircle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // All of this is just demo code.
    var progress : CGFloat = 0.0
    @IBAction func AddQuarterCirclePressed(sender: AnyObject) {
        
        if progress == 4 {
            //Remove the circles we have already drawn
            for view in TheViewForTheCircle.subviews {
                view.removeFromSuperview()
            }

            //Draw the background circle again
            initalizeCircle()

            progress = 0
            
            //Reset the button text
            AddQuarterCircleButton.setTitle("Add a Quarter Circle", forState: UIControlState.Normal)

        } else {
            progress += 1
            
            var newToValue : CGFloat = (progress * 25 / 100) as CGFloat
   
            percentageLabel.text = (newToValue * 100).description + "%"

            // CGFloat.description returns for instance 25.0. We want to get rid of the ".0"
            percentageLabel.text = percentageLabel.text?.stringByReplacingOccurrencesOfString(".0", withString: "", options: .allZeros, range: nil)

            addCircleView(TheViewForTheCircle, isForeground: true, duration: 0.5, fromValue: 0.0,  toValue: newToValue)
        }
        
        // Change the button text once we have filled the circle.
        if progress == 4 {
            AddQuarterCircleButton.setTitle("Reset", forState: UIControlState.Normal)
        }
   }

    // We draw a background circle first becasue it looks better.
    func initalizeCircle() {
        addCircleView(TheViewForTheCircle, isForeground: false, duration: 0.0, fromValue: 0.0,  toValue: 1.0)
        percentageLabel.text = "0%"
    }
    
    //MARK: Add Circle
    func addCircleView( myView : UIView, isForeground : Bool, duration : NSTimeInterval, fromValue: CGFloat, toValue : CGFloat ) {
        var circleWidth = CGFloat(200)
        var circleHeight = circleWidth
        
        // Create a new CircleView
        var circleView = CircleView(frame: CGRectMake(0, 0, circleWidth, circleHeight))
        
        //Setting the color.
        if (isForeground == true) {
            circleView.setStrokeColor("#F2634B".CGColor)
        } else {
            // circleLayer.strokeColor = UIColor.grayColor().CGColor
            //Chose to use hexes because it's much easier.
            circleView.setStrokeColor("#363636".CGColor)
        }
        
        myView.addSubview(circleView)
        
        //Rotate the circle so it starts from the top.
        circleView.transform = CGAffineTransformMakeRotation(-1.56)
        
        // Animate the drawing of the circle
        circleView.animateCircleTo(duration, fromValue: fromValue, toValue: toValue)
    }


}

