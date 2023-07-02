//
//  ScrollPager.swift
//  Assignment
//
//  Created by Shivam Vishwakarma on 01/07/23.
//

import Foundation
import UIKit

@objc public protocol ScrollPagerDelegate: NSObjectProtocol {
    @objc optional func ScrollPager(scrollPager: ScrollPager, changedIndex: Int)
}

@IBDesignable  public class ScrollPager: UIView, UIScrollViewDelegate {
    
    @objc    public var selectedIndex = 0
    @objc    private let indicatorView = UIView()
    @objc    var buttons = [UIButton]()
    @objc    var views = [UIView]()
    @objc    var mainScrollView : UIScrollView? = UIScrollView()
    @objc    private var animationInProgress = false
    @objc    @IBOutlet public weak var objScrollPagerDelegate: ScrollPagerDelegate!
    
    @objc    var isFixTabs = false
    @objc    var numberOfTabs = 2

    @IBOutlet public var scrollView: UIScrollView? {
        didSet {
            scrollView?.delegate = self
            scrollView?.isPagingEnabled = true
            scrollView?.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBInspectable public var textColor: UIColor = UIColor.lightGray {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var selectedTextColor: UIColor = UIColor.darkGray {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var selectedBTNBackgroundColor: UIColor = UIColor.darkGray {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var BTNBackgroundColor: UIColor = UIColor.darkGray {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var fontiPhone: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var fontIpad: UIFont = UIFont.systemFont(ofSize: 24) {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var selectedFontIphone: UIFont = UIFont.boldSystemFont(ofSize: 16) {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var selectedFontIpad: UIFont = UIFont.boldSystemFont(ofSize: 24) {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var indicatorColor: UIColor = UIColor.black {
        didSet { indicatorView.backgroundColor = indicatorColor }
    }
    
    @IBInspectable public var indicatorIsAtBottom: Bool = true {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var indicatorSizeMatchesTitle: Bool = false {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var indicatorHeight: CGFloat = 2.0 {
        didSet { redrawComponents() }
    }
    
    @IBInspectable public var btnCornerRadius: CGFloat = 0.0 {
        didSet { redrawComponents() }
    }
    
//    @IBInspectable public var borderColor: UIColor? {
//        didSet { self.layer.borderColor = borderColor?.cgColor }
//    }
//
//    @IBInspectable public var borderWidth: CGFloat = 0 {
//        didSet { self.layer.borderWidth = borderWidth }
//    }
//
    @IBInspectable public var animationDuration: CGFloat = 0.2
    
    // MARK: - Initializarion -
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    private func initialize() {
        
        
        #if TARGET_INTERFACE_BUILDER
        addSegmentsWithTitles(segmentTitles: ["One", "Two", "Three", "Four"])
        
        #endif
        
        mainScrollView = UIScrollView.init(frame: frame)
        mainScrollView?.bounces = false
        mainScrollView?.showsVerticalScrollIndicator = false
        mainScrollView?.showsHorizontalScrollIndicator = false
        self.addSubview(mainScrollView ?? UIScrollView())
        self.addConstraintProgrammatically(toChildView: mainScrollView  ?? UIScrollView() , fromParentView: self)
    }
    
    // MARK: - UIView Methods -
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        redrawComponents()
        //moveToIndex(selectedIndex, animated: false, moveScrollView: true)
    }
    
    // MARK: - Public Methods -
    
    public func addSegmentsWithTitlesAndViews(segments: [(title: String, view: UIView)]) {
        
        addButtons(titleOrImages: segments.map { $0.title as AnyObject })
        addViews(segmentViews: segments.map { $0.view })
        
        redrawComponents()
    }
    
    @objc public func addSegmentsWithTitlesAndViews(titels: [String] , views : [UIView] ) {
        
        addButtons(titleOrImages: titels.map { $0 as AnyObject })
        addViews(segmentViews: views.map { $0 })
        
        redrawComponents()
    }
    
    public func addSegmentsWithImagesAndViews(segments: [(image: UIImage, view: UIView)]) {
        
        addButtons(titleOrImages: segments.map { $0.image })
        addViews(segmentViews: segments.map { $0.view })
        
        redrawComponents()
    }
    
    public func addSegmentsWithTitles(segmentTitles: [String]) {
        addButtons(titleOrImages: segmentTitles as [AnyObject])
        redrawComponents()
    }
    
    public func addSegmentsWithImages(segmentImages: [UIImage]) {
        addButtons(titleOrImages: segmentImages)
        redrawComponents()
    }
    
    public func setSelectedIndex(index: Int, animated: Bool) {
        setSelectedIndex(index: index, animated: animated, moveScrollView: true)
    }
    
    // MARK: - Private -
    
    private func setSelectedIndex(index: Int, animated: Bool, moveScrollView: Bool) {
        selectedIndex = index
        
        moveToIndex(index: index, animated: animated, moveScrollView: moveScrollView)
    }
    
    private func addViews(segmentViews: [UIView]) {
        guard let scrollView = scrollView else { fatalError("trying to add views but the scrollView is nil") }
        
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        
        views.removeAll()
        
        for i in 0..<segmentViews.count {
            let view = segmentViews[i]
            scrollView.addSubview(view)
            views.append(view)
        }
    }
    
    private func addButtons(titleOrImages: [AnyObject]) {
        
        mainScrollView!.bounces = false
        
        for button in buttons {
            button.removeFromSuperview()
        }
        
        buttons.removeAll()
        var buttonWidth = 0
        
        for i in 0..<titleOrImages.count {
            let button = UIButton(type: .custom)
            button.titleLabel?.lineBreakMode = .byWordWrapping
            button.titleLabel?.numberOfLines = 2
            button.tag = i
            button.addTarget(self, action: #selector(ScrollPager.buttonSelected(sender:)), for: .touchUpInside)
            
//            button.titleLabel?.font = UIDevice.current.userInterfaceIdiom ? self.fontIpad : self.fontiPhone
            if let title = titleOrImages[i] as? String {
                button.setTitle(title, for: .normal)
            }
            else if let image = titleOrImages[i] as? UIImage {
                button.setImage(image, for: .normal)
            }
            
            button.titleLabel?.sizeToFit()
            button.sizeToFit()
            buttonWidth += Int(button.frame.size.width)
            buttons.append(button)
            
            // button.translatesAutoresizingMaskIntoConstraints = true;
            
            mainScrollView?.addSubview(button)
            mainScrollView?.addSubview(indicatorView)
            mainScrollView?.layoutSubviews()
            //addSubview(button)
            //addSubview(indicatorView)
        }
        
    }
    
    private func moveToIndex(index: Int, animated: Bool, moveScrollView: Bool) {
        animationInProgress = true
  
        UIView.animate(withDuration: animated ? TimeInterval(animationDuration) : 0.0, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in
            
            guard let strongSelf = self else { return }
            //  let width = strongSelf.frame.size.width / CGFloat(strongSelf.buttons.count)
            // button.titleLabel?.sizeToFit()
            // let width : CGFloat = (button.titleLabel?.intrinsicContentSize.width)!
            strongSelf.redrawButtons()
            let button = strongSelf.buttons[index]
            
            let width : CGFloat = button.frame.size.width
            
            let indicatorY: CGFloat = strongSelf.indicatorIsAtBottom ? strongSelf.frame.size.height - strongSelf.indicatorHeight : 0
            
            if strongSelf.indicatorSizeMatchesTitle {
                guard let string = button.titleLabel?.text else { fatalError("missing title on button, title is required for width calculation") }
                guard let font = button.titleLabel?.font else { fatalError("missing dont on button, title is required for width calculation")  }
                let size = string.size(withAttributes: [NSAttributedString.Key.font: font])
                //  let x = width * CGFloat(index) + ((width - size.width) / CGFloat(2))
                // strongSelf.indicatorView.frame = CGRect(x: x, y: indicatorY, width: button.frame.size.width, height: strongSelf.indicatorHeight)
                //  strongSelf.indicatorView.frame = CGRect(x: width * CGFloat(index), y: indicatorY, width: button.frame.size.width, height: strongSelf.indicatorHeight)
                strongSelf.indicatorView.frame = CGRect(x: button.frame.origin.x , y: indicatorY, width: size.width, height: strongSelf.indicatorHeight)
            } else {
                strongSelf.indicatorView.frame = CGRect(x: button.frame.origin.x , y: indicatorY, width: width, height: strongSelf.indicatorHeight)
            }
            
            if let scrollView : UIScrollView = strongSelf.mainScrollView {
                if !scrollView.bounds.contains(button.frame) {
                    scrollView.scrollRectToVisible(button.frame, animated: true)
                }
            }
            
            if let scrollView = strongSelf.scrollView {
                if moveScrollView {
                    scrollView.contentOffset = CGPoint(x: CGFloat(index) * scrollView.bounds.size.width, y: 0)
                }
            }
            
            }, completion: { [weak self] finished in
                // Storyboard crashes on here for some odd reasons, do a nil check
                self?.animationInProgress = false
        })
    }
    
    private func redrawComponents() {
        
        redrawButtons()
        
        if buttons.count > 0 {
            moveToIndex(index: selectedIndex, animated: false, moveScrollView: false)
        }
        
        if let scrollView = self.scrollView {
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(buttons.count), height: scrollView.frame.size.height)
            
            for i in 0..<views.count {
                views[i].frame = CGRect(x: scrollView.frame.size.width * CGFloat(i), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
            }
        }
    }
    
    private func redrawButtons() {
        if buttons.count == 0 {
            return
        }
        
        //    let width = frame.size.width / CGFloat(buttons.count)
        let height = frame.size.height - indicatorHeight - 4
        let y: CGFloat = indicatorIsAtBottom ? 4 : indicatorHeight
        
        
        let inBetweenGap : CGFloat = 0.00
        var x : CGFloat = inBetweenGap //+ (self.frame.size.width/3)
        var totalWidth : CGFloat = inBetweenGap
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.setTitleColor((i == selectedIndex) ? selectedTextColor : textColor, for: .normal)
            button.backgroundColor = (i == selectedIndex) ? selectedBTNBackgroundColor : BTNBackgroundColor
            if UIDevice.current.userInterfaceIdiom == .pad {
                button.titleLabel?.font = (i == selectedIndex) ? selectedFontIpad : fontIpad
            } else {
                button.titleLabel?.font = (i == selectedIndex) ? selectedFontIphone : fontiPhone
            }
            
            button.layer.cornerRadius = btnCornerRadius
            button.sizeToFit()
            button.titleLabel?.sizeToFit()
            button.titleLabel?.textAlignment = .center
            let size = button.titleLabel?.text!.size(withAttributes: [NSAttributedString.Key.font: button.titleLabel?.font as Any ])
            
            var buttonWidth  : CGFloat = 70.00;

//            if((size?.width)! > 70.00)
//            {
                buttonWidth = (size?.width)! + 16
//            }
            
            if isFixTabs {
                let withddd = mainScrollView?.frame.size.width ?? 0
                buttonWidth = withddd/CGFloat(numberOfTabs)
                button.frame = CGRect(x: x , y: y, width: buttonWidth , height: height)
            }
            
            x = x + buttonWidth + inBetweenGap
            if i == buttons.count-1 {
                totalWidth = totalWidth +  buttonWidth + (inBetweenGap * 2)
            } else {
                 totalWidth = totalWidth +  buttonWidth + inBetweenGap
            }
            mainScrollView?.layoutSubviews()
        }
        
        mainScrollView?.contentSize = CGSize.init(width: (totalWidth + inBetweenGap), height: self.frame.size.height)
//        if mainScrollView?.contentSize.width ?? 0 < mainScrollView?.frame.width ?? 0 {
//            mainScrollView?.contentSize = CGSize.init(width: self.frame.width, height: self.frame.size.height)
//            mainScrollView?.isScrollEnabled = false
//        }else{
//            mainScrollView?.contentSize = CGSize.init(width: (totalWidth + inBetweenGap), height: self.frame.size.height)
//            mainScrollView?.isScrollEnabled = true
//        }
    }
    
    @objc internal func buttonSelected(sender: UIButton) {
        if sender.tag == selectedIndex {
            return
        }
        
        objScrollPagerDelegate?.ScrollPager?(scrollPager: self, changedIndex: sender.tag)
        
        setSelectedIndex(index: sender.tag, animated: true, moveScrollView: true)
    }
    
    // MARK: - UIScrollView Delegate -
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !animationInProgress {
            var page = scrollView.contentOffset.x / scrollView.frame.size.width
            
            if page.truncatingRemainder(dividingBy: 1) > 0.5 {
                page = page + CGFloat(1)
            }
            
            if Int(page) != selectedIndex {
                setSelectedIndex(index: Int(page), animated: true, moveScrollView: false)
                objScrollPagerDelegate?.ScrollPager?(scrollPager: self, changedIndex: Int(page))
            }
        }
    }
    
    func addConstraintProgrammatically(toChildView objChildView: UIView?, fromParentView objParentView: UIView?) {
        
        objChildView?.translatesAutoresizingMaskIntoConstraints = false
        
        //Trailing
        let trailing = NSLayoutConstraint(item: objChildView as Any, attribute: .trailing, relatedBy: .equal, toItem: objParentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        //Leading
        
        let leading = NSLayoutConstraint(item: objChildView as Any, attribute: .leading, relatedBy: .equal, toItem: objParentView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        //Bottom
        let bottom = NSLayoutConstraint(item: objChildView as Any, attribute: .bottom, relatedBy: .equal, toItem: objParentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        var width: NSLayoutConstraint? = nil
        if let by = NSLayoutConstraint.Relation(rawValue: 0) {
            width = NSLayoutConstraint(item: objChildView as Any, attribute: .width, relatedBy: by, toItem: objParentView, attribute: .width, multiplier: 1.0, constant: 0)
        }
        var height: NSLayoutConstraint? = nil
        if let by = NSLayoutConstraint.Relation(rawValue: 0) {
            height = NSLayoutConstraint(item: objChildView as Any, attribute: .height, relatedBy: by, toItem: objParentView, attribute: .height, multiplier: 1.0, constant: 0)
        }
        
        //Add constraints to the Parent
        objParentView?.addConstraint(trailing)
        objParentView?.addConstraint(bottom)
        objParentView?.addConstraint(leading)
        
        //Add height constraint to the subview, as subview owns it.
//        objChildView?.addConstraint(height ?? NSLayoutConstraint())
//        objChildView?.addConstraint(width ?? NSLayoutConstraint())
        
        if let height = height {
            objParentView?.addConstraint(height)
        }
        if let width = width {
            objParentView!.addConstraint(width)
        }
    }
}
