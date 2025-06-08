import SwiftUI

struct AnasayfaView: View {
    @State private var searchText: String = ""
    @State private var showAllProductsSheet = false
    @State private var selectedColor: String = "Tüm Renkler"
    @State private var selectedFabric: String = "Tüm Kumaşlar"
    
    let colors = ["Tüm Renkler", "Kırmızı", "Mavi", "Yeşil", "Siyah", "Beyaz"]
    let fabrics = ["Tüm Kumaşlar", "Deri", "Keten"]
    
    let featuredProducts = [
        Product(id: 1, name: "Öne Çıkan Ürün 1", price: 399.99, color: "Kırmızı", fabric: "Deri"),
        Product(id: 2, name: "Öne Çıkan Ürün 2", price: 249.99, color: "Mavi", fabric: "Keten"),
        Product(id: 3, name: "Öne Çıkan Ürün 3", price: 149.99, color: "Yeşil", fabric: "Deri")
    ]
    
    struct Product: Identifiable {
        var id: Int
        var name: String
        var price: Double
        var color: String
        var fabric: String
        
    }

    var body: some View {
        NavigationStack {
            ScrollView{
            VStack {
                
                Button(action: {
                    showAllProductsSheet = true
                }) {
                    HStack {
                        Image(systemName: "cart.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        Text("Tüm Ürünler")
                            .font(.headline)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]),
                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white.opacity(0.6), lineWidth: 2)
                    )
                    .scaleEffect(showAllProductsSheet ? 1.05 : 1)
                    .animation(.easeInOut(duration: 0.3), value: showAllProductsSheet)
                }
                .padding(.horizontal)
                
                
                Text("Öne Çıkan Ürünler")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(featuredProducts) { product in
                            ZStack(alignment: .topTrailing) {
                                VStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 150, height: 150)
                                        .overlay(Text("Resim"))
                                        .cornerRadius(10)
                                    
                                    Text(product.name)
                                        .font(.headline)
                                        .padding(.top, 5)
                                    
                                    Text("₺\(product.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                    
                                    Button(action: {
                                        // Sepete ekle işlemi yapılacak
                                    }) {
                                        Text("Sepete Ekle")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.purple)
                                            .cornerRadius(10)
                                    }
                                    .padding(.top, 5)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                
                                // Kalp ikonu
                                Button(action: {
                                    // Favori ekleme işlemi yapılacak
                                }) {
                                    Image(systemName: "heart")
                                        .foregroundColor(.red)
                                        .padding(8)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .shadow(radius: 2)
                                }
                                .padding(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                NavigationLink(destination: RedProductsView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]),
                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(height: 200)

                        HStack {
                            Image(systemName: "photo.fill")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("Resimli Buton")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                
                Spacer()
                    
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: profilView()) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.purple)
                    }}
                }
            }
        }
        .searchable(text: $searchText)
        .sheet(isPresented: $showAllProductsSheet) {
            TumUrunlerView(selectedColor: $selectedColor, selectedFabric: $selectedFabric)
        }
    }
}

struct TumUrunlerView: View {
    @Binding var selectedColor: String
    @Binding var selectedFabric: String
    
    let colors = ["Tüm Renkler", "Kırmızı", "Mavi", "Yeşil", "Siyah", "Beyaz"]
    let fabrics = ["Tüm Kumaşlar", "Deri", "Keten"]
    
    @Environment(\.dismiss) var dismiss
    
    struct Product: Identifiable, Hashable {
        var id: Int
        var name: String
        var price: Double
        var color: String
        var fabric: String
    }
    
    @State private var products: [Product] = [
        Product(id: 1, name: "Ürün 1", price: 299.99, color: "Kırmızı", fabric: "Deri"),
        Product(id: 2, name: "Ürün 2", price: 199.99, color: "Mavi", fabric: "Keten"),
        Product(id: 3, name: "Ürün 3", price: 499.99, color: "Siyah", fabric: "Deri"),
        Product(id: 4, name: "Ürün 4", price: 149.99, color: "Yeşil", fabric: "Keten"),
        Product(id: 5, name: "Ürün 5", price: 349.99, color: "Beyaz", fabric: "Deri"),
        Product(id: 6, name: "Ürün 6", price: 249.99, color: "Kırmızı", fabric: "Keten")
    ]
    
    @State private var showFilters = false
    @State private var favoriteProducts: Set<Int> = []  // Favori ürün ID'lerini saklar
    @State private var cartItems: [Product] = [] // Sepet ürünleri
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Button(action: {
                        showFilters.toggle()
                    }) {
                        Text("Filtrele")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple.opacity(0.2))
                            .foregroundColor(.purple)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    if showFilters {
                        VStack {
                            Picker("Renk", selection: $selectedColor) {
                                ForEach(colors, id: \.self) { color in
                                    Text(color)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding()
                            
                            Picker("Kumaş", selection: $selectedFabric) {
                                ForEach(fabrics, id: \.self) { fabric in
                                    Text(fabric)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding()
                        }
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(products.filter { (selectedColor == "Tüm Renkler" || $0.color == selectedColor) && (selectedFabric == "Tüm Kumaşlar" || $0.fabric == selectedFabric) }) { product in
                            ZStack(alignment: .topTrailing) {
                                VStack {
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
                                    
                                    Button(action: {
                                        cartItems.append(product)
                                    }) {
                                        Text("Sepete Ekle")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.purple)
                                            .cornerRadius(10)
                                    }
                                    .padding(.top, 5)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                
                                // Kalp ikonu
                                Button(action: {
                                    if favoriteProducts.contains(product.id) {
                                        favoriteProducts.remove(product.id)
                                    } else {
                                        favoriteProducts.insert(product.id)
                                    }
                                }) {
                                    Image(systemName: favoriteProducts.contains(product.id) ? "heart.fill" : "heart")
                                        .foregroundColor(.red)
                                        .padding(8)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .shadow(radius: 2)
                                }
                                .padding(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
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

struct RedProductsView: View {
    var body: some View {
        Text("Kırmızı Ürünler")
            .font(.largeTitle)
            .bold()
    }
}
// Arama çubuğu bileşeni
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Ara...", text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    Spacer()
                }
            )
            .padding(.horizontal)
    }
}

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

struct FavorilerView: View {
    var body: some View {
        VStack {
            Text("Favoriler Sayfası")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Favoriler")
    }
}

struct SepetView: View {
    var body: some View {
        VStack {
            Text("Sepet Sayfası")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Sepet")
    }
}

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
        }
        .tint(.purple)
    }
}

#Preview {
    MainTabView()
}

