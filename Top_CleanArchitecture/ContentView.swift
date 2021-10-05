//
//  ContentView.swift
//  Top_CleanArchitecture
//
//  Created by Islam Md. Zahirul on 4/10/21.
//

import SwiftUI


extension Font {
    static func boldFont(size: CGFloat) -> Font {
        return .system(size: size, weight: .bold, design: .default)
    }
    static func normal(size: CGFloat) -> Font {
        return .system(size: size)
    }
}

struct HeadLineView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title.uppercased())
                .font(Font.boldFont(size: 21.0))
            Spacer()
        }//:HStack
        .padding(.horizontal)
        
    }
}


struct PagingScrollView<Content: View>: View {
    let axis: Axis.Set
    let content: Content
    
    init(axis: Axis.Set, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axis, showsIndicators: false, content: {
            LazyStack(axis: axis) {
                content
            }
        })
    }
}

struct LazyStack<Content: View>: View {
    let axis: Axis.Set
    let content: Content
    
    init(axis: Axis.Set, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content()
    }
    
    var body: some View {
        if axis == .vertical {
            LazyVStack {
                content
            }
        } else {
            LazyHStack {
                content
            }
        }
    }
}


struct CoponView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5.0)
            .fill(Color.gray)
            .shadow(color: .black, radius: 5, x: .zero, y: .zero)
    }
}

struct AppButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            HStack {
            Text(title)
                .font(Font.normal(size: 14.0))
                .foregroundColor(Color.white)
            }//: HStack
            .frame(width: 201, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 5.0)
                .fill(Color.black)
            )
            
        })
    }
}

struct NewsView: View {
    var body: some View {
        VStack {
            HStack {
                CoponView()
                    .frame(width: 84, height: 84)
                
                VStack(alignment: .leading) {
                    Text("Title")
                    Text("Subtitle")
                    Text("Description")
                    Text("Create Date")
                    Spacer()
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 5.0))
        .shadow(color: .gray, radius: 6, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .padding()
    }
}


struct TopPageItems: View {
    var body: some View {
        HeadLineView(title: "Coupon")
        CoponView()
            .frame(height: 145.0)
            .padding(.horizontal)
       
        HeadLineView(title: "News")
        PagingScrollView(axis: .horizontal) {
            ForEach(0..<20) { i in
                NewsView()
            }
        }
       
        HeadLineView(title: "Events")
        ForEach(0..<20) { i in
            NewsView()
        }
        HeadLineView(title: "Topics")
        PagingScrollView(axis: .horizontal) {
            ForEach(0..<20) { i in
                NewsView()
            }
        }
        HeadLineView(title: "Shops")
        PagingScrollView(axis: .horizontal) {
            ForEach(0..<4) { i in
                NewsView()
            }
        }
    }
}


struct HeaderView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(Font.boldFont(size: 28))
            Spacer()
            Image(systemName: "creditcard")
                .font(.title)
            Image(systemName: "bell")
                .font(.title)
        }
    }
}

struct InlineNavigationView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: @escaping ()->Content) {
        self.content = content()
    }
    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
    }
}

struct AppTapBarView: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
                content:  {
                    TopTabView().tabItem {
                        Label("Top", systemImage: "list.dash")
                            
                    }.tag(1)
                    Text("Tab Content 2").tabItem {  Label("More", systemImage: "square.and.pencil") }.tag(2)
                })
    }
}


struct TopTabView: View {
    var body: some View {
        InlineNavigationView{
        VStack {
            HeaderView(title: "TOP")
                .padding()
            PagingScrollView(axis: .vertical) {
                
                TopPageItems()
            }
        }
       
        }
    }
}


struct ContentView: View {
    var body: some View {
        AppTapBarView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
