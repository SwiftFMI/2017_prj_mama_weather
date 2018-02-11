//
//  NavigationController.swift
//  MamaWeather
//
//  Created by Boyan Vushkov on 10.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import UIKit

class NavigationController: UIPageViewController {
    
    private var orderedViewControllers: [UIViewController] = []
    
    private func instantiateViewController(named identifier: String) -> UIViewController {
        return self.storyboard?.instantiateViewController(withIdentifier: identifier) ?? UIViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        orderedViewControllers = [
            instantiateViewController(named: "SearchViewController"),
            instantiateViewController(named: "HomeViewController")
        ]
        
        if let firstViewController = orderedViewControllers.dropFirst().first {
            setViewControllers([firstViewController],
               direction: .forward,
               animated: true,
               completion: nil)
        }
    }
}

extension NavigationController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        guard nextIndex < orderedViewControllers.count else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
}
