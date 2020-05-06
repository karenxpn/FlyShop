//
//  Loading.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI

struct Loading: View {
    
    var colors: [Color] = [.red, .green, .blue, .yellow]
    @State private var fillPoint = 0.0
    
    private var animation: Animation {
        Animation.linear(duration: 1).repeatForever(autoreverses: false)
    }
    
    var body: some View {
        
        VStack {
            Ring(fillPoint: self.fillPoint).stroke(Color.red, lineWidth: 7)
                .frame(width: 50, height: 50)
                .onAppear{
                    withAnimation( self.animation ) {
                        self.fillPoint = 1.0
                    }
            }
        }.padding()
            .background(Color.gray)
        .cornerRadius(10)
    }
}

struct Ring: Shape {
    var fillPoint: Double
    var delayPoint: Double = 0.5
    
    var animatableData: Double {
        get{ return fillPoint }
        set {fillPoint = newValue }
        
    }
    
    func path(in rect: CGRect) -> Path {
        var start: Double = 0
        let end = 360 * fillPoint
        
        if fillPoint > delayPoint {
            start = ( 2 * fillPoint ) * 360
        } else {
            start = 0
        }
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.height/2),
                    radius: rect.size.width/2,
                    startAngle: .degrees(start),
                    endAngle: .degrees(end),
                    clockwise: false)
        
        return path
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
