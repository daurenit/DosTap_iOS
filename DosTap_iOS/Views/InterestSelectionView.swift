import SwiftUI

struct InterestSelectionView: View {
    // Categories and their options
    let categories: [String: [String]] = [
        "Спорт": ["Хоккей", "Лыжи", "Плавание", "Шахматы", "Теннис", "Футбол", "Волейбол"],
        "Фитнес": ["Прогулка", "Бег", "Плавание", "Танцы", "Хайкинг", "Коньки", "Йога", "Веса"],
        "Хобби и интересы": ["Боулинг", "Велоспорт"],
        "Активный отдых": ["Боулинг", "Велоспорт", "Хайкинг", "Кэмпинг"],
        "Киберспорт": ["Шутеры", "Файтеры"],
        "Искусство и культура": ["Концерты", "Музыка", "Кино", "Искусство"]
    ]

    // Selections
    @State var selectedInterests: [String: Set<String>] = [:]

    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                Text("Dos").font(.largeTitle).bold().foregroundColor(.purple)
                Text(" Tap").font(.largeTitle).bold()
            }
            VStack(alignment: .leading, spacing: 20) {
                Text("Добро пожаловать!")
                    .font(.largeTitle).bold()
                    .padding()
//                Text("Выберите свои интересы")
//                    .font(.title2)
//                    .padding()
                
                
                ForEach(categories.keys.sorted(), id: \.self) { key in
                    VStack(alignment: .leading) {
                        Text(key)
                            .font(.title2)
                            .padding(.leading)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.fixed(80)), count: 4), spacing: 15) {
                            ForEach(categories[key]!, id: \.self) { interest in
                                Button(action: {
                                    toggleSelection(category: key, interest: interest)
                                }) {
                                    Text(interest)
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(width: 75, height: 70)
                                        .background(selectedInterests[key]?.contains(interest) ?? false ? Color.blue : Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                }
                            }
                        }
                        .padding([.leading, .trailing, .bottom])
                    }
                }
                
                Button("Далее") {
                    // Action for next button
                    print("Selected Interests: \(selectedInterests)")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
        }
    }

    func toggleSelection(category: String, interest: String) {
        if selectedInterests[category] == nil {
            selectedInterests[category] = []
        }
        
        if selectedInterests[category]!.contains(interest) {
            selectedInterests[category]!.remove(interest)
        } else {
            selectedInterests[category]!.insert(interest)
        }
    }
}


#Preview {
//    OnboardingView()
    //    RegistrationView()
    InterestSelectionView()
}

