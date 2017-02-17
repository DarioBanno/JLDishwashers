//
//  ImageSliderViewController.swift
//  JLDishwashers
//
//  Created by Dario Banno on 15/02/2017.
//  Copyright © 2017 AppTown. All rights reserved.
//

import UIKit

class ImageSliderViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
    }
    
    func configure(with urls: [URL]) {
        // remove all previous views
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        // set content size
        var contentSize = scrollView.bounds.size
        contentSize.width *= CGFloat(urls.count)
        scrollView.contentSize = contentSize
        
        // udate page control
        pageControl.numberOfPages = urls.count
        
        // create slides
        for index in 0..<urls.count {
            let imageView = generateImageSlide(at: index)
            imageView.errorPlaceholder = #imageLiteral(resourceName: "jlewis-placeholder")
            imageView.contentMode = .scaleAspectFit
            imageView.load(from: urls[index])
            scrollView.addSubview(imageView)
        }
    }

    func generateImageSlide(at index: Int) -> URLImageView {
        var frame = scrollView.bounds
        frame.origin.x = frame.width * CGFloat(index)
        return URLImageView(frame: frame)
    }
    
}

extension ImageSliderViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // update current page in indicator
        let width = scrollView.bounds.size.width
        let pageIndex = Int((scrollView.contentOffset.x + width/2) / width)
        if pageControl.currentPage != pageIndex {
            pageControl.currentPage = pageIndex
        }
    }
    
}
