//
//  ViewController.swift
//  Magic-grid
//
//  Created by Pavan Kumar Reddy on 14/05/17.
//  Copyright © 2017 Pavan. All rights reserved.
//

import UIKit
import AudioToolbox

let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height


class ViewController: UIViewController {

    var cells = [String:UIView]()
    let cellWidth = kWidth/15
    let cellHeight = kHeight/35
    var selectedcell:UIView?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        for j in 0...35
        {
        for i in 0...15
        {
            let objView = UIView(frame: CGRect.init(x: cellWidth * CGFloat(i), y: CGFloat(j)*cellHeight, width: cellWidth, height: cellHeight))
                objView.backgroundColor = randomColor()
                objView.layer.borderColor = UIColor.black.cgColor
                objView.layer.borderWidth = 0.5
                self.view.addSubview(objView)
            
            let key = "\(i)|\(j)"
            cells[key] = objView
        }
            
        }
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    //MARK:Random color
    func randomColor() -> UIColor
    {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    
    //MARK:Touch Events
    func handleTap(gesture:UIPanGestureRecognizer)
    {
        
        let location = gesture.location(in: view)
        
        let i = Int(location.x/cellWidth)
        let j = Int(location.y/cellHeight)
        
        let key = "\(i)|\(j)"
        //let cell = cells[key]
        print(location.x,location.y)
        guard let cell = cells[key]  else {
            return
        }
        
        if selectedcell != cell
        {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
              self.selectedcell?.layer.transform  = CATransform3DIdentity
                
            }, completion: nil)
  
        }
        
        selectedcell = cell
        view.bringSubview(toFront: cell)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            
            cell.layer.transform  = CATransform3DMakeScale(3, 3, 3)
            
        }, completion: nil)
        
        
        if gesture.state == .ended
        {
            AudioServicesPlaySystemSound(1105)

            UIView.animate(withDuration: 0.25, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                
                self.selectedcell?.layer.transform  = CATransform3DIdentity
                
            }, completion: { (_) in
                
            })
        }
 
    }
    

    /*lazy var array:NSArray = {
        let array = NSArray()
        print("arrayLocated")
        return array
    }()
    
    let array2:NSArray = {
        let array = NSArray()
        print("no lazy arrayLocated")
        return array
    }()*/
}

