import SwiftUI

struct ContentView: View {
    
    var screenWidth = UIScreen.main.bounds.width
    @State var xOffset: CGFloat = 0
    @State var currentPage = 0
    var lastPage = data.count - 1
    var firstPage = 0
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                HStack(spacing: 0) {
                    ForEach(data) { item in
                        ItemView(item: item)
                            .frame(width: screenWidth)
                    }
                }
                .offset(x: xOffset)
                .gesture(
                    DragGesture()
                        .onChanged(onChanged)
                        .onEnded(onEnded)
                )
            }
            HStack {
                pageIndicator
                navigationButtons
            }
            .frame(width: 300)
            .frame(height: 55)
            .padding(.horizontal)
            .padding(.top, 650)
        }
    }
    
//    var pageIndicator: some View {
//        HStack(spacing: 6) {
//            ForEach(0..<data.count, id: \.self) { i in
//                Circle()
//                    .frame(width: 20, height: 6)
//                    .foregroundColor(i == currentPage ? .purple : .gray)
//                    .transition(.scale)
//            }
//        }
//    }
    
//    var pageIndicator: some View {
//        ZStack {
//            HStack(spacing: 6) {
//                ForEach(0..<data.count, id: \.self) { i in
//                    Circle()
//                        .frame(width: 20, height: 6)
//                }
//            }
//            .foregroundStyle(.purple)
//            
//        }
//    }
    
    var pageIndicator: some View {
            ZStack {
//                HStack(spacing: 6) {
//                    ForEach(0..<data.count, id: \.self) { i in
//                        Circle()
//                            .frame(width: 30, height: 6)
//                    }
//                }
//                .foregroundStyle(.green)
                
                HStack(spacing: 6) {
                    ForEach(0..<data.count, id: \.self) { i in
                        if i == currentPage {
                            Capsule()
                                .matchedGeometryEffect(id: "page", in: namespace)
                                .frame(width: 30, height: 5)
                                .foregroundStyle(.purple)
                        } else {
                            Rectangle()
                                .frame(width: 15, height: 5)
                                .cornerRadius(20)
                                .foregroundStyle(.gray)
                        }
                    }
                }
//                .foregroundStyle(.purple)
            }
            .animation(.default, value: currentPage) // Animate the page indicator transition
        }
    
//    var navigationButtons: some View {
//        HStack {
//            Spacer() // Pushes the button to the right
//            Button(action: {
//                if currentPage < lastPage {
//                    goToNextPage()
//                }
//            }) {
//                Text(currentPage < lastPage ? "Далее" : "Начать")
//                    .fontWeight(.bold)
//            }
//            .frame(width: 215, height: 55)
//            .background(Color.purple)
//            .foregroundColor(.white)
//            .cornerRadius(30)
//        }
//    }
    
//    var navigationButtons: some View {
//        HStack {
//            Spacer() // Pushes the button to the right
//            Button(action: {
//                if currentPage < lastPage {
//                    goToNextPage()
//                }
//            }) {
//                Text(currentPage < lastPage ? "Далее" : "Начать")
//                    .fontWeight(.bold)
//                    .frame(width: 215, height: 55) // Set the frame of the text
//                    .background(Color.purple) // Background color
//                    .foregroundColor(.white) // Text color
//                    .cornerRadius(30) // Rounded corners
//                    .contentShape(Rectangle()) // This ensures the tappable area is the whole rectangle
//            }
//        }
//    }

    struct SimpleButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .background(Color.purple) // Background color
                .foregroundColor(.white)  // Text color
                .cornerRadius(30)        // Rounded corners
//                .frame(width: 215, height: 55) // Set the frame
                .opacity(configuration.isPressed ? 1.0 : 1.0) // No opacity change on press
        }
    }

    var navigationButtons: some View {
        HStack {
            Spacer() // Pushes the button to the right
            Button(action: {
                if currentPage < lastPage {
                    goToNextPage()
                }
            }) {
                Text(currentPage < lastPage ? "Далее" : "Начать")
                    .fontWeight(.bold)
                    .frame(width: 215, height: 55)
            }
            .buttonStyle(SimpleButtonStyle()) // Apply the custom button style
        }
    }


    func goToNextPage() {
        withAnimation {
            currentPage += 1
            xOffset = -screenWidth * CGFloat(currentPage)
        }
    }

    func onChanged(value: DragGesture.Value) {
        xOffset = value.translation.width - screenWidth * CGFloat(currentPage)
    }
    
    func onEnded(value: DragGesture.Value) {
        let threshold = screenWidth / 2
        if value.translation.width < -threshold {
            if currentPage < lastPage {
                currentPage += 1
            }
        } else if value.translation.width > threshold {
            if currentPage > firstPage {
                currentPage -= 1
            }
        }
        withAnimation {
            xOffset = -screenWidth * CGFloat(currentPage)
        }
    }
}

struct ItemView: View {
    var item: Item
    
    var body: some View {
        ZStack {
            item.backgroundColor
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 100) {
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .fixedSize()
                    .padding(.top, 80)
                
                VStack(spacing: 15) {
                    Text(item.title)
                        .font(.system(size: 34, weight: .bold))
                    
                    Text(item.subtitle)
                        .font(.system(size: 17, weight: .regular))
                }
                .padding(.horizontal)
                Spacer()
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    ContentView()
}

