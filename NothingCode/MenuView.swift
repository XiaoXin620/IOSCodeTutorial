//
//  MenuView.swift
//  NothingCode
//
//  Created by Sample on 2021/7/25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        // SwiftUI 中 颜色都是被看成视图
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                Text("He - 28 complete")
                    .font(.caption)
                
                // 颜色视图
                // 创建多个框架 越开始创建的越在上面 （有待研究）
                Color.white
                    .frame(width: 38, height: 6)
                    .cornerRadius(3.0)
                    .frame(width: 130, height: 6, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .padding()
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign out", icon: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.8954110146, green: 0.9160918593, blue: 0.9564197659, alpha: 1))]), startPoint: .top, endPoint: .bottom)) //color Literal 颜色选择器
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//            .shadow(radius: 30)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20) // 自定义阴影
            .padding(.horizontal, 30)
            .overlay(
                Image("me")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 60, height: 60)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .offset(y: -150)
            )
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            // 使用 SF 图标
            Image(systemName: icon)
                .font(.system(size: 20, weight: .bold))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(width: 120, alignment: .leading)
        }
    }
}
