//
//  RegistrationView.swift
//  DosTap_iOS
//
//  Created by Dauren on 07.05.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isAgeConfirmed: Bool = false
    @State private var isTermsAccepted: Bool = false
    
    private var isFormValid: Bool {
        !name.isEmpty &&
        !username.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        isAgeConfirmed &&
        isTermsAccepted
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                HStack(spacing: 0) {
                    Text("Dos").font(.title).bold().foregroundColor(.purple)
                    Text(" Tap").font(.title).bold()
                }
                
                Text("Регистрация").font(.headline)
                Group {
                    TextField("Имя", text: $name)
                    TextField("Имя пользователя", text: $username)
                    TextField("Email", text: $email)
                    SecureField("Пароль", text: $password)
                    SecureField("Подтвердите пароль", text: $confirmPassword)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Image(systemName: isAgeConfirmed ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            isAgeConfirmed.toggle()
                        }
                    Text("Мне 16 лет или больше")
                    Spacer()
                }
                
                HStack {
                    Image(systemName: isTermsAccepted ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            isTermsAccepted.toggle()
                        }
                    Text("Я ознакомился и принимаю политику и условия использования DosTap")
                    Spacer()
                }
                
                Button(action: {
                    // Registration logic
                }) {
                    Text("Зарегистрироваться")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.purple : Color.gray)
                        .cornerRadius(10)
                        .disabled(!isFormValid)
                }
                
                Button("Войти", action: {
                    // Sign in logic
                })
                .foregroundColor(.purple)
                
                Spacer()
            }
            .padding()
        }
        .background(Color.white)
    }
}

#Preview {
//    OnboardingView()
        RegistrationView()
//    InterestSelectionView()
}
