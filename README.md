# IndicatorViewController
a custom scrollView just with a top animated indicatorBar

## Result


## Installation
> Just copy the file which is in `/Source/IndicatorViewController.swift` into your project.


## Usage
```swift
// initial redViewController
let redViewController = UIViewController()
redViewController.view.backgroundColor = UIColor.redColor()

// initial greenViewController
let greenViewController = UIViewController()
greenViewController.view.background = UIColor.greenColor()

// initial blueViewController
let blueViewController = UIViewController()
blueViewController.view.background = UIColor.blueColor()

// initial every controller`s title
let titles = ["RedView", "GreenView", "BlueView"]

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

```
