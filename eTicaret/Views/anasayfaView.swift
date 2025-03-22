import SwiftUI

struct anasayfaView: View {
    @State private var searchText: String = ""
    @State private var showAllProductsSheet = false // Tüm Ürünler için Sheet State
    @State private var selectedColor: String = "Tüm Renkler"
    @State private var selectedFabric: String = "Tüm Kumaşlar"
        
    let colors = ["Tüm Renkler", "Kırmızı", "Mavi", "Yeşil", "Siyah", "Beyaz"]
    let fabrics = ["Tüm Kumaşlar", "Deri", "Keten"]

    var body: some View {
        NavigationStack {
            VStack {
                // "Tüm Ürünler" Butonu
                Button(action: {
                    showAllProductsSheet = true
                }) {
                    Text("Tüm Ürünler")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple.opacity(0.2))
                        .foregroundColor(.purple)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
                Text("")
                    .font(.title)
                    .foregroundColor(.gray)
                Spacer()
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
        .sheet(isPresented: $showAllProductsSheet) {
            TumUrunlerView(selectedColor: $selectedColor, selectedFabric: $selectedFabric)
        }
    }
}

// Tüm Ürünler Sayfası (Sheet)
struct TumUrunlerView: View {
    @Binding var selectedColor: String
    @Binding var selectedFabric: String
    
    let colors = ["Tüm Renkler", "Kırmızı", "Mavi", "Yeşil", "Siyah", "Beyaz"]
    let fabrics = ["Tüm Kumaşlar", "Deri", "Keten"]
    
    @Environment(\.dismiss) var dismiss
    
    // Ürün model
    struct Product: Identifiable {
        var id: Int
        var name: String
        var price: Double
        var color: String
        var fabric: String
    }
    
    // Örnek Ürün Verisi
    @State private var products: [Product] = [
        Product(id: 1, name: "Ürün 1", price: 299.99, color: "Kırmızı", fabric: "Deri"),
        Product(id: 2, name: "Ürün 2", price: 199.99, color: "Mavi", fabric: "Keten"),
        Product(id: 3, name: "Ürün 3", price: 499.99, color: "Siyah", fabric: "Deri"),
        Product(id: 4, name: "Ürün 4", price: 149.99, color: "Yeşil", fabric: "Keten"),
        Product(id: 5, name: "Ürün 5", price: 349.99, color: "Beyaz", fabric: "Deri"),
        Product(id: 6, name: "Ürün 6", price: 249.99, color: "Kırmızı", fabric: "Keten")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Filtreleme Seçenekleri
                Form {
                    Section(header: Text("Renk Seçimi")) {
                        Picker("Renk", selection: $selectedColor) {
                            ForEach(colors, id: \.self) { color in
                                Text(color)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    Section(header: Text("Kumaş Seçimi")) {
                        Picker("Kumaş", selection: $selectedFabric) {
                            ForEach(fabrics, id: \.self) { fabric in
                                Text(fabric)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                // Ürün Listesi
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(products) { product in
                            VStack {
                                // Ürün Resmi Placeholder
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 150)
                                    .overlay(Text("Resim"))
                                    .cornerRadius(10)
                                
                                Text(product.name)
                                    .font(.headline)
                                    .padding(.top, 5)
                                
                                Text("₺\(product.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("Tüm Ürünler")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kapat") {
                        dismiss()
                    }
                }
            }
        }
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

// ✅ TabView'e Dokunmadım!
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

// Preview
#Preview {
    MainTabView()
}

