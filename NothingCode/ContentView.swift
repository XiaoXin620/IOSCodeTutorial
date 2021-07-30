//
//  ContentView.swift
//  NothingCode
//
//  Created by Sample on 2021/7/25.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        // VStack 纵向 HStack横向 ZStack 三维视图Z轴
        // 在不调节层级情况下 一般最后面的 视图会在最上层
        
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1) // 设置动画延迟时间
                    //                        .speed(2) // 速度
                    //                        .repeatCount(3) // 动画循环 autoreverses 循环
                )
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(Angle(degrees: showCard ? -10: 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20) // 设置偏移
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95) // 缩放
                .rotationEffect(Angle(degrees: show ? 0 : 5)) // 旋转传递角度 可简写.degrees(5)
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0)) // 3d 旋转
                .blendMode(.hardLight) // 混合模式
                .animation(.easeInOut(duration: 0.3)) // 设置动画 一般情况下动画时间小于1s 最好 0.3左右 当然还取决于速度
            
            
            CardView()
                .frame(width: showCard ? 390 : 340.0, height: 220.0) // 设定框架大小
                .background(Color.black)
                //                .cornerRadius(20) // 设置圆角
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous)) // 另一种圆角
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0) // 注意这个偏移是在前一个偏移的基础上开始的
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) // 更改spring动画的 持续时间response  回弹阻尼dampingFraction
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture( // 手势
                    DragGesture() // 拖动手势
                        // 拖动改变时
                        .onChanged(){ value in
                            self.showCard = false
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded(){ value in
                            self.viewState = .zero
                            self.show = false
                        }
                )
            
            BottomView(show: $showCard)
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1,duration: 0.8))
                .gesture(
                    DragGesture()
                        .onChanged(){ value in
                            self.bottomState = value.translation
                            
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                        }
                        .onEnded(){ value in
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            if (self.bottomState.height < -100 && !self.showFull)
                                || (self.bottomState.height < -250 && self.showFull){
                                self.bottomState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                )
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal,20) // 设置padding 默认 16， .padding(.horizontal,20) 简写 设置padding方向
            .padding(.top,20)
            
            Spacer()
            
            Image("Card1")
                .resizable() // 让图片能更改大小
                .aspectRatio(contentMode: .fill) // 调整纵横比 fill：填满， fit: 适合
                .frame(width: 300, height: 110, alignment: .top) // .fill 填满会把文字挤出去，所以设置边框 居上对齐
        }
    }
}

struct BackCardView: View {
    // 每个修饰符的 顺序很重要 比如说下面的 先有框架 然后才设置背景颜色 再设置圆角阴影
    // 如果 shadow 在 cornerRadius 那么 阴影将被裁减
    
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomView: View {
    @Binding var show: Bool
    
    
    var body: some View {
        VStack(spacing: 20.0) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.3)
            
            Text("Design Code is fun. This is haoboxuxu learning SwiftUI to be pro. haoboxuxu has app on the App Store. Search Machine Learning hub")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20.0) {
                // 好像有个动画bug
                RingView(color1: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), color2: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), width: 88, height: 88, percent: 78, show: $show)
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("SwiftUI").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("12 of 12 sections completed\n10 hours spent so fa")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
            
            
            
            Spacer()
        }
        .padding(.top,8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
//        .background(Color.white)
        .background(BlurView(style: .systemThinMaterial)) // 使用自定义模糊
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
