//
//  ImageCarousel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/17/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import Combine

struct ImageCarouselView<Content: View>: View {
    private var numberOfImages: Int
    private var content: Content
    var expanded: Bool
    
    @State private var dragResult: CGFloat = 0
    @State private var currentIndex: Int = 0

    init(numberOfImages: Int, expanded: Bool, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
        self.expanded = expanded
    }
    
    var body: some View {
        // 1
        ZStack(alignment: .bottom) {
            HStack( alignment: .center, spacing: 0) {
                self.content
            }
            .frame(width: UIScreen.main.bounds.size.width, height: self.expanded ? UIScreen.main.bounds.size.height/1.5 : UIScreen.main.bounds.size.height/2, alignment: .leading)
            .offset(x: CGFloat(self.currentIndex) * -UIScreen.main.bounds.size.width, y: 0)
            .animation(.spring())
            .gesture(DragGesture()
            .onChanged({ (gesture) in
                self.dragResult = gesture.translation.width
            })
                .onEnded({ _ in
                    if self.dragResult < 0 {
                        
                        self.currentIndex = ( self.currentIndex + 1 ) % self.numberOfImages
                    } else {
                        if self.numberOfImages == 1 {
                            self.currentIndex = 0
                        } else {
                            self.currentIndex = self.currentIndex == 0 ? self.numberOfImages - abs( self.currentIndex - 1 ) % self.numberOfImages : abs( self.currentIndex - 1 ) % self.numberOfImages
                        }
                        
                    }
                })
                
            )
            
            
            // 2
            HStack(spacing: 3) {
                // 3
                ForEach(0..<self.numberOfImages, id: \.self) { index in
                    // 4
                    Circle()
                        .frame(width: index == self.currentIndex ? 10 : 8,
                               height: index == self.currentIndex ? 10 : 8)
                        .foregroundColor(index == self.currentIndex ? Color(red: 20/255, green: 210/255, blue: 184/255, opacity: 1) : .white)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 8)
                        .animation(.spring())
                }
            }
        }
    }
}
