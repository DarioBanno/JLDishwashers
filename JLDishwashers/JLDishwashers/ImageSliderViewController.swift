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
    
    private var slides: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        pageControl.pageIndicatorTintColor = Resource.Color.contentText
        pageControl.currentPageIndicatorTintColor = Resource.Color.darkText
        pageControl.numberOfPages = 1
        pageControl.hidesForSinglePage = false
        pageControl.isUserInteractionEnabled = false
    }
    
    func configure(with urls: [URL]) {
        // remove all previous slides
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        slides = []
        
        // udate page control
        pageControl.numberOfPages = urls.count
        
        // create slides
        for index in 0..<urls.count {
            let imageView = URLImageView()
            imageView.errorPlaceholder = #imageLiteral(resourceName: "jlewis-placeholder")
            imageView.contentMode = .scaleAspectFit
            imageView.load(from: urls[index])
            scrollView.addSubview(imageView)
            
            slides += [imageView]
        }
        
        // layout slides
        layoutSlides()
    }
    
    private func rectForSlide(at index: Int) -> CGRect {
        var rect = scrollView.bounds
        rect.origin.x = rect.width * CGFloat(index)
        return rect
    }
    
    private func layoutSlides() {
        // update scroll view content size
        var contentSize = scrollView.bounds.size
        contentSize.width *= CGFloat(slides.count)
        scrollView.contentSize = contentSize

        // reposition slides
        for index in 0..<slides.count {
            slides[index].frame = rectForSlide(at: index)
        }
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page);
        frame.origin.y = 0;
        scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Resize all slides: executes in next iteration loop after autolayout calculates all the new constraints for the rotation
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.layoutSlides()
            strongSelf.scrollToPage(page: strongSelf.pageControl.currentPage, animated: true)
        }
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
