//
//  UpdateList.swift
//  NothingCode
//
//  Created by Sample on 2021/7/26.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        store.updates.append(Update(image: "Card1", title: "New Item", text: "Text", date: "Jan 1"))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetail(update: update)){
                        HStack {
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:80 , height: 80)
                                .background(Color.black)
                                .padding(.trailing, 4)
                            
                            VStack(alignment: .leading, spacing: 8.0) {
                                    Text(update.title)
                                        .font(.system(size: 20, weight: .bold))
                                    
                                    Text(update.text)
                                        .lineLimit(2)
                                        .font(.subheadline)
                                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                    
                                    Text(update.date)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                // 删除
                .onDelete { index in
                    self.store.updates.remove(at: index.first!)
                }
                // 移动
                .onMove { (source: IndexSet , destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                    
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle(Text("Updates"))
            // 左边添加按钮
            .navigationBarItems(leading: Button(action: addUpdate){
                Text("Add Update")
            }, trailing: EditButton())
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateData = [
    Update(image: "Card1", title: "SwiftUI Advance", text: "SwiftUI Advance SwiftUI Advance Text", date: "Jun 1"),
    Update(image: "Card2", title: "Webflow", text: "Webflow Webflow Webflow WebflowText", date: "Jun 2"),
    Update(image: "Card3", title: "ProtoPie", text: "ProtoPie ProtoPie ProtoPie ProtoPieText", date: "Jun 3"),
    Update(image: "Card4", title: "SwiftUI", text: "SwiftUI SwiftUI SwiftUI SwiftUI Text", date: "Jun 3"),
    Update(image: "Card5", title: "Framer Playground", text: "Framer Playground Framer Playground Text", date: "Jun 4")
]
