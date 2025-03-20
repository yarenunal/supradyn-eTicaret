//
//  anasayfaView.swift
//  eTicaret
//
//  Created by Yaren on 7.03.2025.
//

import SwiftUI

struct anasayfaView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("") // İçeriği buraya ekleyebilirsin
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: profilView()) { // Hata düzeltildi
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.purple)
                        
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
}

// Profil Sayfası
struct ProfilView: View {
    var body: some View {
        VStack {
            Text("Profil Sayfası")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Profil")
    }
}

// Sepet Sayfası
struct SepetView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sepet Sayfası")
                    .font(.largeTitle)
                    .bold()
                
            }
            .navigationTitle("Sepet")
        }
    }
}

// Favoriler Sayfası
struct FavorilerView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Favoriler Sayfası")
                    .font(.largeTitle)
                    .bold()
            }
            .navigationTitle("Favoriler")
        }
    }
}

// Ana TabBar
struct MainTabView: View {
    var body: some View {
        TabView {
            anasayfaView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Ana Sayfa")
                }

            favorilerView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favoriler")
                }

            sepetView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Sepet")
                }
        }.tint(.purple)
    }
}

// Hata düzeltildi: Preview'da `MainTabView()` çağrıldı
#Preview {
    MainTabView()
}

