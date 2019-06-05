//
//  MUToast.swift
//  MUToast
//
//  Created by Move Upwards on 4 juin 2019.
//  Copyright © 2019 Move Upwards. All rights reserved.
//

// Include Foundation
@_exported import Foundation
import UIKit
import MUHeader

/// Class that define a card (title, description, indicator and image) with screen animation.
@IBDesignable
open class MUToast: UIView {
    private var markerView = UIView()
    private var imageView = UIImageView()
    private var header = MUHeader()
    
    // Image inset constraint
    private var markerWidth: NSLayoutConstraint?
    
    // Image inset constraint
    private var imageLeading: NSLayoutConstraint?
    private var imageWidth: NSLayoutConstraint?
    
    // Labels inset constraints
    private var labelsTop: NSLayoutConstraint?
    private var labelsBottom: NSLayoutConstraint?
    private var labelsLeading: NSLayoutConstraint?
    private var labelsTrailing: NSLayoutConstraint?
    
    private var onTapBlock: (() -> Void)?
    
    // MARK: - Background
    
    /// The toast’s corner radius.
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Header
    
    /// The current title.
    @IBInspectable open var title: String {
        get {
            return header.title
        }
        set {
            header.title = newValue
        }
    }
    
    /// The title’s font.
    open var titleFont: UIFont {
        get {
            return header.titleFont
        }
        set {
            header.titleFont = newValue
        }
    }
    
    /// The title’s text color.
    @IBInspectable open dynamic var titleColor: UIColor {
        get {
            return header.titleColor
        }
        set {
            header.titleColor = newValue
        }
    }
    
    /// The current detail description.
    @IBInspectable open var detail: String {
        get {
            return header.detail
        }
        set {
            header.detail = newValue
        }
    }
    
    /// The detail’s font.
    open var detailFont: UIFont {
        get {
            return header.detailFont
        }
        set {
            header.detailFont = newValue
        }
    }
    
    /// The detail’s text color.
    @IBInspectable open dynamic var detailColor: UIColor {
        get {
            return header.detailColor
        }
        set {
            header.detailColor = newValue
        }
    }
    
    /// The text’s horizontal alignment.
    @objc open dynamic var textAlignment: NSTextAlignment {
        get {
            return header.textAlignment
        }
        set {
            header.textAlignment = newValue
        }
    }
    
    /// Optional: The IBInspectable version of the text’s horizontal alignment.
    @IBInspectable open var textAlignmentInt: Int {
        get {
            return header.textAlignmentInt
        }
        set {
            header.textAlignmentInt = newValue
        }
    }
    
    /// The Title and Detail text vertical spacing.
    @IBInspectable open var spacing: CGFloat {
        get {
            return header.spacing
        }
        set {
            header.spacing = newValue
        }
    }
    
    /// The header’s horizontal padding.
    @IBInspectable open var headerHorizontalPadding: CGFloat = 16.0 {
        didSet {
            labelsLeading?.constant = headerHorizontalPadding
            labelsTrailing?.constant = headerHorizontalPadding
        }
    }
    
    /// The header’s vertical padding.
    @IBInspectable open var headerVerticalPadding: CGFloat = 16.0 {
        didSet {
            labelsTop?.constant = headerVerticalPadding
            labelsBottom?.constant = headerVerticalPadding
        }
    }
    
    // MARK: - ImageView
    
    /// Returns the image of the toast.
    @IBInspectable open dynamic var icon: UIImage? = nil {
        didSet {
            imageView.image = icon
            
            updateImageView()
        }
    }
    
    /// The icon’s left padding.
    @IBInspectable open var iconLeftPadding: CGFloat = 16.0 {
        didSet {
            updateImageView()
        }
    }
    
    /// The icon’s width.
    @IBInspectable open var iconWidth: CGFloat = 36.0 {
        didSet {
            updateImageView()
        }
    }
    
    // MARK: - Indicator
    
    /// The indicator’s width.
    @IBInspectable open dynamic var indicatorWidth: CGFloat = 0.0 {
        didSet {
            markerWidth?.constant = indicatorWidth
        }
    }
    
    /// The indicator’s color.
    @IBInspectable open dynamic var indicatorColor: UIColor = .clear {
        didSet {
            markerView.backgroundColor = indicatorColor
        }
    }
    
    // MARK: - Animation
    
    /// The total duration of the animations, measured in seconds.
    /// If you specify a negative value or 0, the changes are made without animating them.
    @IBInspectable open dynamic var animationDuration: Double = 0.3
    
    /// The total duration of the display, measured in seconds.
    /// If you specify a negative value or 0, the toast will not hide automatically once animation end.
    @IBInspectable open dynamic var displayDuration: Double = 3.0
    
    /// The position where the toast will be visible.
    open var displayPosition: Position = .top
    
    /// The toast's priority. Higher will be on top of lower toasts.
    open var displayPriority: Priority = .info
    
    // MARK: - Toast layout
    
    /// The toast’s horizontal padding.
    @IBInspectable open var horizontalPadding: CGFloat = 16.0
    
    /// The toast’s vertical padding.
    @IBInspectable open var verticalPadding: CGFloat = 16.0
    
    // MARK: - Life cycle
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    convenience public init() {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraint()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupConstraint()
    }
    
    // MARK: - Animation functions
    
    /// Performs a show animation using the animation's values.
    open func show(in vc: UIViewController, onTap: (() -> Void)? = nil, completion: ((Bool) -> Void)? = nil) {
        onTapBlock = onTap
        add(in: vc)
        
        showingAnimation(completion: { [weak self] _ in
            guard let displayDuration = self?.displayDuration, displayDuration > 0 else {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration, execute: {
                self?.hidingAnimation(completion)
            })
        })
    }
    
    /// Optional: If you want to hide the toast sooner than the normal animation.
    open func hide(completion: ((Bool) -> Void)? = nil) {
        hidingAnimation(completion)
    }
    
    // MARK: - Private IBAction functions
    
    @IBAction private func didTap(_ sender: UITapGestureRecognizer) {
        onTapBlock?()
    }
    
    // MARK: - Private variables
    
    private var hideTransform: CGAffineTransform {
        switch displayPosition {
        case .top:
            return CGAffineTransform(translationX: 0.0, y: -(frame.origin.y + frame.height))
        case .bottom:
            guard let superviewFrame = superview?.frame else {
                return .identity
            }
            return CGAffineTransform(translationX: 0.0, y: superviewFrame.height - frame.origin.y)
        }
    }
    
    // MARK: - Private functions
    
    private func setup() {
        setupMarker()
        addSubview(imageView)
        
        addSubview(header)
    }
    
    private func setupMarker() {
        markerView.backgroundColor = indicatorColor
        addSubview(markerView)
        
        let markerWidth = NSLayoutConstraint(item: markerView,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: .notAnAttribute,
                                             multiplier: 1,
                                             constant: indicatorWidth)
        markerWidth.isActive = true
        self.markerWidth = markerWidth
        
        markerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        markerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        markerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupConstraint() {
//        let imageLeading = NSLayoutConstraint(item: detailLabel,
//                                              attribute: .top,
//                                              relatedBy: .equal,
//                                              toItem: titleLabel,
//                                              attribute: .bottom,
//                                              multiplier: 1,
//                                              constant: spacing)
//        imageLeading.isActive = true
//
//        let imageWidth = NSLayoutConstraint(item: detailLabel,
//                                            attribute: .top,
//                                            relatedBy: .equal,
//                                            toItem: titleLabel,
//                                            attribute: .bottom,
//                                            multiplier: 1,
//                                            constant: spacing)
//        imageWidth.isActive = true
//
//        let labelsTop = NSLayoutConstraint(item: detailLabel,
//                                           attribute: .top,
//                                           relatedBy: .equal,
//                                           toItem: titleLabel,
//                                           attribute: .bottom,
//                                           multiplier: 1,
//                                           constant: spacing)
//        labelsTop.isActive = true
//
//        let labelsBottom = NSLayoutConstraint(item: detailLabel,
//                                              attribute: .top,
//                                              relatedBy: .equal,
//                                              toItem: titleLabel,
//                                              attribute: .bottom,
//                                              multiplier: 1,
//                                              constant: spacing)
//        labelsBottom.isActive = true
//
//        let labelsLeading = NSLayoutConstraint(item: detailLabel,
//                                               attribute: .top,
//                                               relatedBy: .equal,
//                                               toItem: titleLabel,
//                                               attribute: .bottom,
//                                               multiplier: 1,
//                                               constant: spacing)
//        labelsLeading.isActive = true
//
//        let labelsTrailing = NSLayoutConstraint(item: detailLabel,
//                                                attribute: .top,
//                                                relatedBy: .equal,
//                                                toItem: titleLabel,
//                                                attribute: .bottom,
//                                                multiplier: 1,
//                                                constant: spacing)
//        labelsTrailing.isActive = true
    }
    
    private func updateImageView() {
        imageLeading?.constant = icon == nil ? 0.0 : iconLeftPadding
        imageWidth?.constant = icon == nil ? 0.0 : iconWidth
    }
    
    private func expectedSize(in width: CGFloat) -> CGSize {
        var size = CGSize(width: width - 2.0 * horizontalPadding, height: 0.0)
        
        let headerWidth = size.width - iconLeftPadding - iconWidth - 2.0 * headerHorizontalPadding
        
        var headerHeight = header.expectedHeight(for: headerWidth)
        if headerHeight < iconWidth {
            headerHeight = iconWidth
        }
        size.height = headerHeight + 2.0 * headerVerticalPadding
        
        return size
    }
    
    private func add(in vc: UIViewController) {
        let safeArea = vc.areaFrame
        let size = expectedSize(in: safeArea.width)
        let origin: CGFloat
        
        if displayPosition == .top {
            origin = safeArea.origin.y + verticalPadding
            transform = CGAffineTransform(translationX: 0.0, y: -(origin + size.height))
        } else {
            origin = safeArea.origin.y + safeArea.height - size.height - verticalPadding
            transform = CGAffineTransform(translationX: 0.0, y: vc.view.frame.height - origin)
        }
        
        switch displayPriority {
        case .alert:
        break // Default case on top of all views
        case .warning:
            if let toastView = getLowestToast(in: vc.view, priorities: [.alert]) {
                vc.view.insertAutolayoutSubview(self,
                                                belowSubview: toastView,
                                                top: origin,
                                                height: nil,
                                                leading: safeArea.origin.x + horizontalPadding,
                                                width: size.width / vc.view.bounds.width)
                return
            }
        case .info:
            if let toastView = getLowestToast(in: vc.view, priorities: [.alert, .warning]) {
                vc.view.insertAutolayoutSubview(self,
                                                belowSubview: toastView,
                                                top: origin,
                                                height: nil,
                                                leading: safeArea.origin.x + horizontalPadding,
                                                width: size.width / vc.view.bounds.width)
                return
            }
        }
        
        vc.view.addAutolayoutSubview(self,
                                     top: origin,
                                     height: nil,
                                     leading: safeArea.origin.x + horizontalPadding,
                                     width: size.width / vc.view.bounds.width)
    }
    
    private func getLowestToast(in vcView: UIView, priorities: [Priority]) -> UIView? {
        var returnView: UIView?
        for subview in vcView.subviews {
            if let v = subview as? MUToast, priorities.contains(v.displayPriority) {
                returnView = v
                break
            }
        }
        return returnView
    }
    
    private func showingAnimation(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                        self?.transform = .identity
            }, completion: { completed in
                completion?(completed)
        })
    }
    
    private func hidingAnimation(_ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        guard let strongSelf = self else {
                            return
                        }
                        strongSelf.transform = strongSelf.hideTransform
            }, completion: { [weak self] completed in
                self?.onTapBlock = nil
                self?.removeFromSuperview()
                completion?(completed)
        })
    }
}
