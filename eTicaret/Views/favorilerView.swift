import SwiftUI

struct favorilerView: View {
    // Örnek favori ürünler
    let favoriUrunler = [
        Product(id: 5, name: "Ürün 5", price: 349.99, color: "Beyaz", fabric: "Deri"),
        Product(id: 6, name: "Ürün 6", price: 229.50, color: "Siyah", fabric: "Pamuk")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(favoriUrunler) { urun in
                        ZStack(alignment: .topTrailing) {
                            VStack(alignment: .leading, spacing: 10) {
                                // Ürün görsel alanı (şu an yer tutucu)
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 150)
                                    .overlay(Text("Resim").foregroundColor(.gray))
                                    .cornerRadius(10)
                                
                                Text(urun.name)
                                    .font(.headline)
                                
                                Text("₺\(urun.price, specifier: "%.2f")")
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                                
                                Text("Renk: \(urun.color)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text("Kumaş: \(urun.fabric)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Button(action: {
                                    // Sepete ekle işlemi
                                }) {
                                    Text("Sepete Ekle")
                                        .fontWeight(.semibold)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .frame(maxWidth: .infinity)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .leading, endPoint: .trailing))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .padding(.top, 5)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            
                            // Favori butonu (kalp ikonu)
                            Button(action: {
                                // Favoriden çıkar işlemi
                            }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                    .padding(10)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 3)
                            }
                            .padding(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Favoriler")
        }
    }
}

// Mevcut Product modeliyle uyumlu hale getirmek için:
struct Product: Identifiable {
    var id: Int
    var name: String
    var price: Double
    var color: String
    var fabric: String
}

#Preview {
    favorilerView()
}

