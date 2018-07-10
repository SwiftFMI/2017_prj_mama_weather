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
    var pageControl = UIPageControl()
    
    private func instantiateViewController(named identifier: String) -> UIViewController {
        return self.storyboard?.instantiateViewController(withIdentifier: identifier) ?? UIViewController()
    }
    
    func goHome(with city: City) {
        if let homeViewController = orderedViewControllers.dropFirst().first as? HomeViewController,
            let forecastViewController = orderedViewControllers.last as? ForecastViewController {
            homeViewController.cityId = city.id
            forecastViewController.setSelectedCity(city)
            setViewControllers([homeViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
    }
    private func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        view.addSubview(pageControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        orderedViewControllers = [
            instantiateViewController(named: "SearchViewController"),
            instantiateViewController(named: "HomeViewController"),
            instantiateViewController(named: "ForecastViewController")
        ]
        
        delegate = self
        configurePageControl()
        
        if let firstViewController = orderedViewControllers.dropFirst().first {
            setViewControllers([firstViewController],
               direction: .forward,
               animated: true,
               completion: nil)
        }
    }
}

extension NavigationController : UIPageViewControllerDelegate {
    
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
