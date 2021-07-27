//
//  RingView.swift
//  NothingCode
//
//  Created by Sample on 2021/7/27.
//

import SwiftUI

struct RingView: View {
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var width: CGFloat = 44
    var height: CGFloat = 44
    var percent: CGFloat = 88
    @Binding var show: Bool
    
    var body: some View {
        let multiplier = width / 44  // 计算缩放大小的倍数 以方便计算里面整体的缩放 基础为44
        let progress = 1 - percent / 100 // 计算trim的长度 因为tirm 是从1开始计算的 所以要1 -
        // 因为上面有参数 ， view不能默认返回 要显示返回
        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1),style: StrokeStyle(lineWidth:5 * multiplier))
                .frame(width: width, height: height) // 添加z轴下面突出 指示器
            
            Circle()
                .trim(from: show ? progress : 1, to: 1) // 间隔 从0.2 开始 到圆结束 1
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]),
                                   startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0)) // 一个圆 空心圆
                .animation(Animation.easeInOut.delay(0.3)) // 添加动画 并延迟
                .rotationEffect(Angle(degrees: 90)) // 旋转  因为 trim 是从右边 最顶点开始的 所以要调整位置 并使用3d旋转 使圆翻转到上顶点开始
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1, y: 0, z: 0)
                )
                .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            //                .animation(.easeInOut) // 此动画的优先级要先于父容器
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/) // 圆中心的数字
                .onTapGesture {
                    self.show.toggle()
                }
            
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
