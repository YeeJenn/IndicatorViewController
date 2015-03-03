//
//  UICustomScrollView.swift
//  Weef
//
//  a scroll view with indicator
//
//  Created by Mr.Jim on 2/10/15.
//  Copyright (c) 2015 Jim. All rights reserved.
//

import UIKit

class IndicatorViewController: UIViewController, UIScrollViewDelegate {


    
    // content viewControllers
    var contentViewControllers: [UIViewController]!
    
    // content viewControllers' titles
    var indicatorTitles: [String]!
    
    
    // the scrollView which controls content views' scroll event
    var scrollView: UIScrollView!
    
    
    // indicator bar which shows the current viewController's title
    var indicatorBar: UIView!
    
    // the buttons in the indicator bar
    private var indicatorButtons: [UIButton]?
    
    
    // current viewController's index
    var defaultPage: Int = 0 {
        didSet{
            self.changeTheCurrentPageWithPageIndex(defaultPage)
        }
    }
    
    var currentPage: Int {
        get{
            return defaultPage
        }

        set {
            
        }
    }
    
    // indicator buttons' text color for deselected state
    var deselectedColor: UIColor = UIColor.grayColor(){
        didSet{

            self.indicatorButtonActivedWithAnimation(pageIndex: currentPage, ratio: 1.3)
        }
    }
    
    // indicator buttons' text color for selected state
    var selectedColor: UIColor = UIColor.purpleColor() {
        didSet{

            self.indicatorButtonActivedWithAnimation(pageIndex: currentPage, ratio: 1.3)
        }
    }
    
    
    init(indicatorTitles: [String], contentViewControllers: [UIViewController]) {
        self.indicatorTitles = indicatorTitles
        self.contentViewControllers = contentViewControllers
        super.init(nibName: nil, bundle: nil)
    }
 
    required init(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup the indicator bar
        setupIndicatorBar()

        // setup the scrollView
        setupScrollView()
    }
    
    
    

    // Create indicator bar with indicatorTitles
    private func setupIndicatorBar() {
        
        indicatorButtons = [UIButton]()
        
        // the count of either indicatorTitles or contentViewControllers
        // decides the number of the indicator buttons
        let numberOfButtons = indicatorTitles.count
        
        
        //indicator bar(without any buttons now )
        indicatorBar = UIView()
        indicatorBar.frame = CGRectMake(0, 0, self.view.bounds.width, 40)
        let borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 255/255)
        indicatorBar.layer.borderColor = borderColor.CGColor
        indicatorBar.layer.borderWidth = 1
        indicatorBar.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(indicatorBar)
        

        
        //inital all the indicator buttons
        for index in 0..<numberOfButtons {
            let button = UIButton.buttonWithType(.System) as UIButton
            button.setTitle(indicatorTitles[index], forState: .Normal)
            button.addTarget(self, action: "indicatorButtonDidTap:", forControlEvents: .TouchUpInside)
            button.setTitleColor(deselectedColor, forState: .Normal)
            
            
            // select the button corresponding to the currentPage
            if index == currentPage {
                button.setTitleColor(selectedColor, forState: .Normal)
            }
            
            let x = indicatorBar.bounds.width * CGFloat(index) / CGFloat(numberOfButtons)
            let y: CGFloat = 0
            let width = UIScreen.mainScreen().bounds.width / CGFloat(numberOfButtons)
            let height: CGFloat = 40
            button.frame = CGRectMake(x, y, width, height)
            indicatorButtons!.append(button)
            indicatorBar.addSubview(button)
            self.addChildViewController(contentViewControllers[index])
            
        }

    }
    
    
    
    // Create scrollView with contentViewControllers' views
    private func setupScrollView() {

        
        let scrollViewFrame = CGRectMake(0, indicatorBar.frame.height, self.view.bounds.width, self.view.bounds.height - (indicatorBar.frame.height))
        
        scrollView = UIScrollView(frame: scrollViewFrame)
        
        scrollView.contentSize = CGSizeMake(scrollView.frame.width * CGFloat(contentViewControllers.count), self.view.bounds.height - 60)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        
        
        
        let size = scrollView.bounds.size
        for index in 0..<contentViewControllers.count {
            contentViewControllers[index].view.frame.origin = CGPointMake(size.width * CGFloat(index), 0)
            contentViewControllers[index].view.frame.size = size
            scrollView.addSubview(self.contentViewControllers[index].view)
        }
        
        self.view.addSubview(scrollView)
    }
    
    
    
    // when indicator button is tapped
    func indicatorButtonDidTap(sender: UIButton) {
        let title = sender.titleLabel!.text!
        for index in 0..<indicatorButtons!.count {
            if indicatorButtons![index].titleLabel!.text! == title {
                changeTheCurrentPageWithPageIndex(index)
            }
        }
    }
    
    
    //change the current page
    func changeTheCurrentPageWithPageIndex(currentIndex: Int) {
        
        var currentFrame = scrollView.frame
        
        currentFrame.origin.x = scrollView.frame.size.width * CGFloat(currentIndex)
        
        //change the indicator buttons' state
        indicatorButtonActivedWithAnimation(pageIndex: currentPage, ratio: 1.3)
        
        //chage the current view in the scorll view
        scrollView.scrollRectToVisible(currentFrame, animated: false)
    }

    
    
    
    
    // change the selected button
    func indicatorButtonActivedWithAnimation(pageIndex currentIndex: Int, ratio: CGFloat) {
        for index in 0..<indicatorButtons!.count {
            let button = indicatorButtons![index]
            if index == currentIndex {
                animatedTheButton(button, color: selectedColor, ratio: ratio)
            } else {
                animatedTheButton(button, color: deselectedColor, ratio: 1.0)
    
            }
        }
    }
    
    
    
    // animated the button
    func animatedTheButton(button: UIButton, color: UIColor, ratio: CGFloat){
        dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                button.transform = CGAffineTransformMakeScale(ratio, ratio)
                button.setTitleColor(color, forState: .Normal)
                }, completion: nil)
        }
    }

    
    
    
    // MARK: scrollView delegate method
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // offset per view
        let perOffset = scrollView.contentOffset.x % scrollView.frame.size.width
        
        // when scroll ratio from 1.3 to 1.0
        let scaleRatio = -0.3*(perOffset / scrollView.frame.size.width) + 1.3
        
        let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width + 1/2)
        
        indicatorButtonActivedWithAnimation(pageIndex: index, ratio: scaleRatio)
        currentPage = index
        
    }
    
    
}
