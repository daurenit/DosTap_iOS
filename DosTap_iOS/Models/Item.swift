//
//  Item.swift
//  DosTap_iOS
//
//  Created by Dauren on 18.03.2024.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID().uuidString
    let backgroundColor: Color
    let image: String
    let title: String
    let subtitle: String
    
}

let data = [

    Item(backgroundColor: Color("Color2"), image: "Illustration-3", title: "Найдите события по душе", subtitle: "Отправляйтесь в путешествие по миру событий, открывайте то, что действительно вам по душе, и наслаждайтесь волнующими встречами и развлечениями."),
    
    Item(backgroundColor: Color("Color2"), image: "Illustration-4", title: "Найдите единомышленников", subtitle: "Найдите тех, кто разделяет ваши интересы, ценности и взгляды, чтобы вместе находить новые вдохновляющие идеи, делиться опытом и создавать крепкие связи."),
    
    Item(backgroundColor: Color("Color2"), image: "Group 76", title: "Исследуйте свой город ", subtitle: "Открывайте  уникальные уголки своего города, встречайте новых людей, погружайтесь в культуру и историю, и наслаждайтесь всем тем, что ваш город может предложить.")
    
]

