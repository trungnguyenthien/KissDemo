//
//  Test.swift
//  KissUI-Lib
//
//  Created by Trung on 5/27/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation
import UIKit
import YogaKit

class LayoutAttribute {
    var paddingLeft: Double = 0 // internal(set)
    var paddingRight: Double = 0
    var paddingTop: Double = 0
    var paddingBottom: Double = 0

    var userMarginLeft: Double = 0
    var userMarginRight: Double = 0
    var userMarginTop: Double = 0
    var userMarginBottom: Double = 0

    var grow: Double?
    var ratio: Double?

    var userWidth: Double?
    var userHeight: Double?
    var maxHeight: Double?
    var minHeight: Double?
    var forcedWidth: Double?
    var forcedHeight: Double?

    var minWidth: Double?
    var maxWidth: Double?

    var forcedLeft: Double = 0
    var forcedRight: Double = 0
    var forcedTop: Double = 0
    var forcedBottom: Double = 0

    var alignStack = MainAxisAlignment.start
    var alignItems = CrossAxisAlignment.start
    var alignSelf: CrossAxisAlignment?
}

extension LayoutAttribute: NSCopying {
    public func copy(with _: NSZone? = nil) -> Any {
        let instance = LayoutAttribute()

        instance.paddingLeft = paddingLeft
        instance.paddingRight = paddingRight
        instance.paddingTop = paddingTop
        instance.paddingBottom = paddingBottom

        instance.userMarginLeft = userMarginLeft
        instance.userMarginRight = userMarginRight
        instance.userMarginTop = userMarginTop
        instance.userMarginBottom = userMarginBottom

        instance.grow = grow
        instance.ratio = ratio

        instance.userWidth = userWidth
        instance.userHeight = userHeight
        instance.maxHeight = maxHeight
        instance.minHeight = minHeight
        instance.maxWidth = maxWidth
        instance.minWidth = minWidth

        instance.forcedLeft = forcedLeft
        instance.forcedRight = forcedRight
        instance.forcedTop = forcedTop
        instance.forcedBottom = forcedBottom

        instance.alignStack = alignStack
        instance.alignItems = alignItems
        instance.alignSelf = alignSelf

        return instance
    }
}

// MARK: - Mapping LayoutAttribute to YGLayout

extension LayoutAttribute {
    func map(to l: YGLayout) {
        l.paddingLeft = YGValueOrUndefined(paddingLeft)
        l.paddingRight = YGValueOrUndefined(paddingRight)
        l.paddingTop = YGValueOrUndefined(paddingTop)
        l.paddingBottom = YGValueOrUndefined(paddingBottom)

        l.marginLeft = YGValueOrUndefined(forcedLeft)
        l.marginRight = YGValueOrUndefined(forcedRight)
        l.marginTop = YGValueOrUndefined(forcedTop)
        l.marginBottom = YGValueOrUndefined(forcedBottom)

        l.maxHeight = YGValueOrUndefined(maxHeight)
        l.minHeight = YGValueOrUndefined(minHeight)

        l.minWidth = YGValueOrUndefined(minWidth)
        l.maxWidth = YGValueOrUndefined(maxWidth)

        switch alignStack {
        case .start: l.justifyContent = .flexStart
        case .end: l.justifyContent = .flexEnd
        case .center: l.justifyContent = .center
        }

        switch alignItems {
        case .start: l.alignItems = .flexStart
        case .end: l.alignItems = .flexEnd
        case .center: l.alignItems = .center
        case .stretch: l.alignItems = .stretch
        }

        switch alignSelf {
        case .some(.center): l.alignSelf = .center
        case .some(.start): l.alignSelf = .flexStart
        case .some(.end): l.alignSelf = .flexEnd
        case .some(.stretch): l.alignSelf = .stretch
        case .none: l.alignSelf = .auto
        }

        if let grow = self.grow {
            setGrow(grow: grow, to: l)
        }
        if let fWidth = forcedWidth {
            l.width = YGValueOrAuto(fWidth)
        } else {
            l.width = YGValueOrAuto(userWidth)
        }

        if let fHeight = forcedHeight {
            l.height = YGValueOrAuto(fHeight)
        } else {
            l.height = YGValueOrAuto(userHeight)
        }

        if let ratio = self.ratio {
            l.aspectRatio = CGFloat(ratio)
        }
    }
}
