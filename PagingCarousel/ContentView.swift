//
//  ContentView.swift
//  PagingCarousel
//
//  Created by Al Amin on 13/5/20.
//  Copyright © 2020 Al Amin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var menu = 0
    @State private var page = 0
   // @State private var text = "Enter your text"
    var body: some View {
        ZStack{
            Color("Color").edgesIgnoringSafeArea(.all)
            VStack {
               ZStack {
                    HStack {

                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Image("Menu")
                                .renderingMode(.original)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        Spacer()


                        Image("pic")

                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(10)

                    }
                    .padding(.horizontal)
                    Text("Food Items")
                        .font(.system(size: 22))
                }
               HStack (spacing: 15) {

                    Button(action: {
                        self.menu = 0
                    }) {
                        Text("Chinese")
                            .padding(.horizontal,20)
                            .padding(.vertical, 10)
                            .foregroundColor(menu == 0 ? .white : .black)
                    }
                    .background(menu == 0 ? Color.black : Color.white)
                    .clipShape(Capsule())
                   // Spacer()
                    Button(action: {
                        self.menu =  1
                    }) {
                        Text("Italian")
                            .padding(.horizontal,20)
                            .padding(.vertical, 10)
                            .foregroundColor(menu == 1 ? .white : .black)
                    }
                    .background(menu == 1 ? Color.black : Color.white)
                    .clipShape(Capsule())
                   // Spacer()
                    Button(action: {
                        self.menu  = 2
                    }) {
                        Text("Mexcican")
                            .padding(.horizontal,20)
                            .padding(.vertical, 10)
                            .foregroundColor(menu == 2 ? .white : .black)
                    }
                    .background(menu == 2 ? Color.black : Color.white)
                    .clipShape(Capsule())


                }
                .padding(.top, 30)
               .padding(.bottom, 25)
                
                
                    GeometryReader { geometry in
                        Carousel(width: UIScreen.main.bounds.width, page: self.$page, height: geometry.size.height)
                    // MyList()
//
                  }
                
                PageControl(page: self.$page)
                

            }
            .padding(.vertical)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var datas = [Type(id: 0, name: "Soba Noodles", cName: "Chinese", price: "$25",image: "soba"),Type(id: 1, name: "Rice Stick Noodles", cName: "Italian", price: "$18",image: "rice"),Type(id: 1, name: "Rice Stick Noodles", cName: "Italian", price: "$18",image: "rice"),Type(id: 2, name: "Hokkien Noodles", cName: "Chinese", price: "$55",image: "hokkien"),Type(id: 3, name: "Mung Bean Noodles", cName: "Chinese", price: "$29",image: "bean"),Type(id: 4, name: "Udon Noodles", cName: "Chinese", price: "$15",image: "udon")]


struct MyList: View {
    var body: some View {
        
        HStack (spacing: 0){
            ForEach(datas){ data in
                VStack {
                   
                    VStack {
                        Text(data.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top,20)
                        Text(data.cName)
                            .foregroundColor(.gray)
                            .padding(.vertical)
                         Spacer(minLength: 0)
                        Image(data.image)
                            .resizable()
                            .cornerRadius(20)
                            .frame(width: UIScreen.main.bounds.width - 80, height: 250)
                        
                        Text(data.price)
                            .fontWeight(.bold)
                            .font(.title)
                            .padding([.top,.bottom], 20)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("Buy")
                                .padding(.horizontal, 40)
                                .padding(.vertical, 10)
                        }
                        .foregroundColor(.black)
                        .background(Color("Color"))
                        .clipShape(Capsule())
                        //.padding()
                         Spacer(minLength: 0)
                    }
                        
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 30)
                    .background(Color.white)
                    .cornerRadius(15)
                  
                    
                }
                 .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}

struct Carousel: UIViewRepresentable {
    
    
    var width : CGFloat
    @Binding var page: Int
    var height: CGFloat
    func makeUIView(context: Context) -> UIScrollView{
        let total = width * CGFloat( datas.count )
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.contentSize = CGSize(width: total, height: 1)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator  = false
        view.delegate = context.coordinator
        let view1 = UIHostingController(rootView: MyList())
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: height)
        view1.view.backgroundColor = .clear
        
        view.addSubview(view1.view)
        return view
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Carousel.Coordinator(parent1: self)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent : Carousel
        init(parent1: Carousel) {
            parent = parent1
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
            
            self.parent.page = page
        }
    }
}

struct PageControl: UIViewRepresentable {
    @Binding var page: Int
    func makeUIView(context: Context) -> UIPageControl {
        let view = UIPageControl()
        view.currentPageIndicatorTintColor = .black
        view.numberOfPages = datas.count
        view.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        DispatchQueue.main.async {
            uiView.currentPage = self.page
        }
    }
}


//struct TextView: UIViewRepresentable {
//
//
//
//    @Binding var text: String
//    func makeUIView(context: Context) -> UITextView {
//        let textViews = UITextView()
//       // textView.font = UIFont.preferredFont(forTextStyle: textStyle)
//        textViews.autocapitalizationType = .words
//        textViews.isSelectable = true
//       // textViews.delegate = context.coordinator
//        return textViews
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        uiView.text = text
//
//    }
//
//    class Coordinator: NSObject, UITextViewDelegate {
//        var text: Binding<String>
//
//        init(_ text: Binding<String>) {
//            self.text = text
//        }
//        func textViewDidChange(_ textView: UITextView) {
//            self.text.wrappedValue = textView.text
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator($text)
//    }
//}
