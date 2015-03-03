//
//  ViewController.swift
//  IndicatorViewController-sample
//
//  Created by Mr.Jim on 3/2/15.
//  Copyright (c) 2015 Jim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation items
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 170/255, blue: 255/255, alpha: 255/255)
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // content views' frame
        let x: CGFloat = 0
        let y = self.navigationController!.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.height
        let width = self.view.bounds.width
        let height = self.view.bounds.height - y
        
        let contentFrame = CGRectMake(x, y, width, height)
        
        // create contentViewControllers' titles
        let titles = ["RedView","GreenView", "BlueView"]
        
        // create the redViewController
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = UIColor.redColor()
        
        // create the green view
        let greenViewController = UIViewController()
        greenViewController.view.backgroundColor = UIColor.greenColor()
        
        // create the blue view
        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = UIColor.blueColor()
        
        // collect three viewControllers
        let viewControllers = [redViewController, greenViewController, blueViewController]
        
        // create the indicatorViewController
        let indicatorViewController = IndicatorViewController(indicatorTitles: titles, contentViewControllers: viewControllers)
        // set the indicatorViewController's view frame
        indicatorViewController.view.frame = contentFrame

        // set the indicator button's text color for selected state
        indicatorViewController.selectedColor = UIColor(red: 0/255, green: 170/255, blue: 255/255, alpha: 255/255)
        // set the indicator button's text color for deselected state
        indicatorViewController.deselectedColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 150/255)
        // set the default currentPage
        indicatorViewController.defaultPage = 1
        
        self.view.addSubview(indicatorViewController.view)
        self.addChildViewController(indicatorViewController)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

