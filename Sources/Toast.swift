//
//  Toast.swift
//  Toast-iOS
//
//  Created by Loïc GRIFFIE on 06/06/2019.
//  Copyright © 2019 Move Upwards. All rights reserved.
//

import SwiftUI
import MUHeader

public struct Toast : View {
    // MARK: - Indicator
    
    /// The indicator’s width.
    var indicatorWidth: CGFloat = 12.0
    
    /// The indicator’s color.
    var indicatorColor: Color = .clear
    
    // MARK: - Icon
    
    /// Returns the image of the toast.
    var icon: String = ""
    
    /// The icon’s left padding.
    var iconLeftPadding: CGFloat = 16.0
    
    // MARK: - Header
    
    /// The current title.
    var title: String = ""
    
    /// The title’s text color.
    var titleColor: Color = .primary
    
    /// The current detail description.
    var detail: String = ""
    
    /// The detail’s text color.
    var detailColor: Color = .secondary
    
    /// The text’s horizontal alignment.
    var textAlignment: Alignment = .leading
    
    /// The Title and Detail text vertical spacing.
    var spacing: Length = 8
    
    /// The header’s horizontal padding.
    var horizontalPadding: CGFloat = 16.0
    
    /// The header’s vertical padding.
    var verticalPadding: CGFloat = 16.0
    
    // MARK: - Animation
    
    /// The total duration of the animations, measured in seconds.
    /// If you specify a negative value or 0, the changes are made without animating them.
    var animationDuration: Double = 0.3
    
    /// The total duration of the display, measured in seconds.
    /// If you specify a negative value or 0, the toast will not hide automatically once animation end.
    var displayDuration: Double = 3.0
    
    /// The position where the toast will be visible.
    var displayPosition: Position = .top
    
    /// The toast's priority. Higher will be on top of lower toasts.
    var displayPriority: Priority = .info
    
    public var body: some View {
        HStack(spacing: horizontalPadding) {
            Image(icon)
                .padding(.leading, horizontalPadding)
                .padding([.top, .bottom], verticalPadding)
            
            Header(title: title,
                   titleColor: titleColor,
                   spacing: spacing,
                   detail: detail,
                   detailColor: detailColor).padding([.top, .bottom], verticalPadding)
            
            Spacer(minLength: horizontalPadding)
        }
        .background(Color.green)
        .padding(.leading, indicatorWidth)
        .background(indicatorColor)
    }
}

#if DEBUG
struct Toast_Previews : PreviewProvider {
    static var previews: some View {
        Toast(indicatorWidth: 12,
              indicatorColor: .orange,
              icon: "reddit",
              title: "My title",
              titleColor: .white,
              detail: "My detail text goes here",
              detailColor: .white,
              spacing: 0,
              horizontalPadding: 16)
            .cornerRadius(8)
    }
}
#endif
