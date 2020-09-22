//
//  ProfileMainViewController.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 23/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import UIKit

class ProfileMainViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    let dataSource = getProfile()
    var currentViewControllerIndex = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
       
    }
    
    func configurePageViewController(){
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else{
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        // add this as a child of this VC.
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        // add subview to content view
        contentView.addSubview(pageViewController.view)
        
        let views: [String: Any] = ["pageView": pageViewController.view!]
       
       // for the page view, flush againsts the edges 0 poits away from super view through the horizontal and vertical constratins
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else{
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
    }
    
    func detailViewControllerAt(index: Int) -> ProfileDataViewController? {
        
        if index >= dataSource.count || dataSource.count == 0{
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: ProfileDataViewController.self)) as? ProfileDataViewController else{
            return nil
        }
        
        dataViewController.dataIndex = index
//        dataViewController.index(ofAccessibilityElement: index)
        dataViewController.displayText = dataSource[index]
        
        
        
        return dataViewController
    }
    

}

extension ProfileMainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        let dataViewController = viewController as? ProfileDataViewController
        
        guard var currentIndex = dataViewController?.dataIndex else{
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0{
            return nil
        }
        
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? ProfileDataViewController
        
        guard var currentIndex = dataViewController?.dataIndex else{
            return nil
        }
        
        if currentIndex == dataSource.count{
            return nil
        }
        
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        
       return detailViewControllerAt(index: currentIndex)
    }
    
    
}
