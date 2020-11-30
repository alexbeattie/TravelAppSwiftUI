//
//  DestinationHeaderContainer.swift
//  TravelApp
//
//  Created by Alex Beattie on 11/30/20.
//

import SwiftUI

struct DestinationHeaderContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        
        //UIHostingController Code
        //let redVC = UIHostingController(rootView: Text("FirstViewController"))
        //return redVC
        let pvc = CustomPageViewController()
        return pvc
    }
    
    typealias UIViewControllerType = UIViewController
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allViewControllers.firstIndex(of: viewController) else { return nil }
        if index == 0 { return nil }
        return allViewControllers[index - 1]

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = allViewControllers.firstIndex(of: viewController) else { return nil }
        if index == allViewControllers.count - 1 { return nil }
        return allViewControllers[index + 1]
                
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allViewControllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
    let firstVC = UIHostingController(rootView: Text("First View Controller"))
    let secondVC = UIHostingController(rootView: Text("Second View Controller"))
    let thirdVC = UIHostingController(rootView: Text("Third View Controller"))
    lazy var allViewControllers:[UIViewController] = [firstVC, secondVC,thirdVC]
    init() {
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct DestinationHeaderContainer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DestinationHeaderContainer()
            NavigationView {
                PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eifell", latitude: 48.855014, longitude: 2.341231))

            }
        }
    }
}
