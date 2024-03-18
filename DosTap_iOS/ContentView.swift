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
            VStack {
                Spacer()
                pageIndicator
                if currentPage != lastPage {
                    navigationButtons
                } else {
                    startButton
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20) // Ensure buttons are above any home indicator
        }
    }
    
    var pageIndicator: some View {
        ZStack {
            HStack(spacing: 6) {
                ForEach(0..<data.count, id: \.self) { i in
                    Circle()
                        .frame(width: 10, height: 6)
                }
            }
            .foregroundStyle(.white)
            
            HStack(spacing: 6) {
                ForEach(0..<data.count, id: \.self) { i in
                    if i == currentPage {
                        Capsule()
                            .matchedGeometryEffect(id: "page", in: namespace)
                            .frame(width: 18, height: 6)
                    } else {
                        Circle()
                            .frame(width: 10, height: 6)
                    }
                }
            }
            .foregroundStyle(.white)
        }
        .animation(.default, value: currentPage) // Animate the page indicator transition
    }
    
    var navigationButtons: some View {
        HStack {
            Button(action: skipToEnd) {
                Text("Skip")
                    .frame(maxWidth: .infinity)
            }
            Spacer()
            Button(action: goToNextPage) {
                HStack {
                    Text("Next")
                }
                .font(.system(size: 17, weight: .bold))
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 60)
        .foregroundColor(.white)
    }
    
    var startButton: some View {
        Button(action: {}) {
            Text("Start")
                .foregroundStyle(.blue)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Capsule().fill(Color.white))
        }
    }

    func skipToEnd() {
        currentPage = lastPage
        withAnimation { xOffset = -screenWidth * CGFloat(lastPage) }
    }

    func goToNextPage() {
        currentPage += 1
        withAnimation { xOffset = -screenWidth * CGFloat(currentPage) }
    }

    func onChanged(value: DragGesture.Value) {
        xOffset = value.translation.width - screenWidth * CGFloat(currentPage)
    }
    
    func onEnded(value: DragGesture.Value) {
        if -value.translation.width > screenWidth / 2 && currentPage < lastPage {
            currentPage += 1
        } else if value.translation.width > screenWidth / 2 && currentPage > firstPage {
            currentPage -= 1
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
            
            VStack(spacing: 20) {
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top)
                
                VStack(spacing: 15) {
                    Text(item.title)
                        .font(.system(size: 40, weight: .semibold))
                    
                    Text(item.subtitle)
                        .font(.system(size: 20, weight: .regular))
                }
                .padding(.horizontal)
                Spacer()
            }
            .foregroundStyle(.white)
        }
    }
}
