import SwiftUI

struct anasayfaView: View {
    @State private var searchText: String = ""
    @State private var showAllProductsSheet = false // Tüm Ürünler için Sheet State
    @State private var selectedColor: String = "Tüm Renkler"
    @State private var selectedFabric: String = "Tüm Kumaşlar"
    
    let colors = ["Tüm Renkler", "Kırmızı", "Mavi", "Yeşil", "Siyah", "Beyaz"]
    let fabrics = ["Tüm Kumaşlar", "Deri", "Keten"]
    
    // Öne Çıkarılan Ürünler Listesi
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
            VStack {
                // "Tüm Ürünler" Butonu
                Button(action: {
                    showAllProductsSheet = true
                }) {
                    HStack {
                        Image(systemName: "cart.fill")  // Sepet simgesi ekleniyor
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
                                       startPoint: .topLeading, endPoint: .bottomTrailing) // Renk geçişi
                    )
                    .cornerRadius(15)  // Yuvarlak köşeler
                    .shadow(radius: 10) // Gölgelendirme
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white.opacity(0.6), lineWidth: 2) // Kenar çizgisi
                    )
                    .scaleEffect(showAllProductsSheet ? 1.05 : 1) // Butonun tıklanabilirliğini arttıran etki
                    .animation(.easeInOut(duration: 0.3), value: showAllProductsSheet) // Buton animasyonu
                }
                .padding(.horizontal)
                
                // Öne Çıkan Ürünler Başlığı
                Text("Öne Çıkan Ürünler")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // Yatay Kaydırılabilir Öne Çıkan Ürünler
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(featuredProducts) { product in
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
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                }

                // Resimli Buton, tüm yatay satırı dolduruyor ve ekranın geri kalan kısmını kaplıyor
                NavigationLink(destination: RedProductsView()) { // NavigationLink eklendi
                    ZStack {
                        // Butonun arka planını oluşturuyoruz
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]),
                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(height: 200) // Butonun boyunu belirliyoruz (yükseklik)

                        // Butonun içeriğini yerleştiriyoruz
                        HStack {
                            Image(systemName: "photo.fill")  // Resim simgesi
                                .font(.title)
                                .foregroundColor(.white)
                            Text("Resimli Buton")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()  // Butonun içindeki öğelerin yatayda yayılmasını sağlar
                        }
                        .padding()
                        .frame(maxWidth: .infinity)  // Ekranın geri kalan kısmını kaplar
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)  // Ekranın geri kalan kısmını kaplar.
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

struct TumUrunlerView: View {
    @Binding var selectedColor: String
    @Binding var selectedFabric: String
    
    let colors = ["Tüm Renkler", "Kırmızı", "Mavi", "Yeşil", "Siyah", "Beyaz"]
    let fabrics = ["Tüm Kumaşlar", "Deri", "Keten"]
    
    @Environment(\.dismiss) var dismiss
    
    struct Product: Identifiable {
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
    
    var body: some View {
        NavigationStack {
            ScrollView {  // ScrollView içine aldık
                VStack {
                    // "Filtrele" butonu
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
                    
                    // Filtreler bölümü
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
                    
                    // Ürünler
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(products.filter { $0.color == "Kırmızı" || selectedColor == "Tüm Renkler" }) { product in
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
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
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
