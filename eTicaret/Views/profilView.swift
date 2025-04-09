import SwiftUI

struct Siparis: Identifiable {
    let id = UUID()
    let urunAdi: String
    let fiyat: Double
    let gorselAdi: String // Assets içindeki görsel adı
}

struct profilView: View {
    
    // Örnek sipariş verileri
    let siparisler: [Siparis] = [
        Siparis(urunAdi: "Kırmızı Elbise", fiyat: 499.99, gorselAdi: "elbise"),
        Siparis(urunAdi: "Spor Ayakkabı", fiyat: 799.50, gorselAdi: "ayakkabi"),
        Siparis(urunAdi: "Deri Cüzdan", fiyat: 259.00, gorselAdi: "cuzdan")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Tüm Siparişlerim")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)

                List {
                    ForEach(siparisler) { siparis in
                        HStack(spacing: 15) {
                            Image(siparis.gorselAdi)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .cornerRadius(10)

                            VStack(alignment: .leading, spacing: 5) {
                                Text(siparis.urunAdi)
                                    .font(.headline)
                                Text(String(format: "%.2f TL", siparis.fiyat))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(PlainListStyle())

                // Çıkış butonu en altta
                Button(action: {
                    // Çıkış işlemi burada yapılır
                    print("Çıkış yapıldı")
                }) {
                    Text("Çıkış Yap")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.red)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
            }
            .navigationBarTitle("Profil", displayMode: .inline)
        }
    }
}

#Preview {
    profilView()
}

