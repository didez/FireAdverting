//
//  NativeAdView.swift
//
//  Copyright 2018-2019 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

import MoPub
import UIKit

/**
 Provides a common native ad view.
 */
@IBDesignable
public class NativeAdView: UIView {
    // IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainTextLabel: UILabel!
    @IBOutlet var callToActionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var privacyInformationIconImageView: UIImageView!
//    @IBOutlet weak var videoView: UIView!

    // IBInspectable
    @IBInspectable var nibName: String? = "NativeAdView"

    // Content View
    private(set) var contentView: UIView?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupNib()
    }

    /**
     The function is essential for supporting flexible width. The native view content might be
     stretched, cut, or have undesired padding if the height is not estimated properly.
     */
    static func estimatedViewHeightForWidth(_ width: CGFloat) -> CGFloat {
        // The numbers are obtained from the constraint defined in the xib file
        let padding: CGFloat = 8
        let iconImageViewWidth: CGFloat = 50
        let estimatedNonMainContentCombinedHeight: CGFloat = 72 // [title, main text, call to action] labels

        let mainContentWidth = width - padding * 3 - iconImageViewWidth
        let mainContentHeight = mainContentWidth / 2 // the xib has a 2:1 width:height ratio constraint
        return floor(mainContentHeight + estimatedNonMainContentCombinedHeight + padding * 2)
    }

    func setupNib() {
        guard let view = loadViewFromNib(nibName: nibName) else { return }

        mainImageView.accessibilityIdentifier = AccessibilityIdentifier.nativeAdImageView

        addSubview(view)
        contentView = view
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView?.frame = bounds
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupNib()
        contentView?.prepareForInterfaceBuilder()
    }
}

extension NativeAdView: MPNativeAdRendering {
    // MARK: - MPNativeAdRendering

    public func nativeTitleTextLabel() -> UILabel! {
        return titleLabel
    }

    public func nativeMainTextLabel() -> UILabel! {
        return mainTextLabel
    }

    public func nativeCallToActionTextLabel() -> UILabel! {
        return callToActionLabel
    }

    public func nativeIconImageView() -> UIImageView! {
        return iconImageView
    }

    public func nativeMainImageView() -> UIImageView! {
        return mainImageView
    }

    public func nativePrivacyInformationIconImageView() -> UIImageView! {
        return privacyInformationIconImageView
    }

//    func nativeVideoView() -> UIView! {
//        return videoView
//    }
}
