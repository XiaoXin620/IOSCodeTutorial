//
//  LoginView.swift
//  NothingCode
//
//  Created by Sample on 2021/7/31.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)
            // 两个背景颜色 让第二个 安全区底部对其 调整alignment
            Color("background2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
            
            CouverView()
            
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                        .padding(.leading)
                    
                    TextField("Your Email".uppercased(), text: $email)
                        .keyboardType(.emailAddress)
                        .font(.subheadline)
                        // 使用 系统样式 让输入框增大
                        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        //                    .background(Color.orange)
                        .padding(.leading)
                        .frame(height: 44)// padding fram 不会增大点击区域
                    //                        .background(Color.blue)
                }
                
                Divider()
                    .padding(.vertical, 2)
                    .padding(.leading, 80)
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                        .padding(.leading)
                    
                    SecureField("Password".uppercased(), text: $password)
                        .keyboardType(.default)
                        .font(.subheadline)
                        .padding(.leading)
                        .frame(height: 44)
                }
            }
            .frame(height: 136)
            .frame(maxWidth: .infinity)
            .background(BlurView(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
            .padding(.horizontal)
            .offset(y: 460)
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CouverView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn design & code. \nFrom scratch")
                    // geometry.size.width 获取屏幕宽度375
                    .font(.system(size: geometry.size.width/10,weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.horizontal, 16)
            // 除以 让数值变小 不然移动那么大距离
            .offset(x: viewState.width/15, y: viewState.height/15)
            
            Text("80 hours of courses for SwiftUI, React and design tools.")
                .font(.subheadline)
                .frame(width: 250)
                .offset(x: viewState.width/20, y: viewState.height/20)
            
            Spacer()
        }
        // 应用到父容器中也会应用到子容器上 multilineTextAlignment
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            // 重复叠加层 渲染图片
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -150, y: -200)
                    // 这里 + 90 是因为原本就有90的偏移 动画只是从 90-360 循环所以要 +90
                    .rotationEffect(Angle(degrees: show ? 360 + 90 : 90))
                    .blendMode(.plusDarker)
                    // 重复动画 持续时间变长动画变慢
                    //                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    .animation(nil)
                    .onAppear{ self.show = true }
                
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250)
                    // anchor 旋转的锚点
                    .rotationEffect(Angle(degrees: show ? 360: 0), anchor: .leading)
                    .blendMode(.overlay)
                    //.animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                    .animation(nil)
            }
        )
        .background(
            Image(uiImage: #imageLiteral(resourceName: "Card3"))
                .offset(x: viewState.width/20, y: viewState.height/20),
            alignment: .bottom
        )
        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        // 动画放在3d动画之前 如果放在后面 会有些许跳帧
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(
            Angle(degrees: 5),
            axis: (x: viewState.width, y: viewState.height, z: 0)
        )
        .gesture(
            DragGesture().onChanged(){ value in
                self.viewState = value.translation
            }.onEnded{ value in
                self.viewState = .zero
            }
        )
    }
}
