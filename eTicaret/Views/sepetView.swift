// sepetView.swift

import SwiftUI

struct SepetUrun: Identifiable, Equatable {
    let id = UUID()
    let urunAdi: String
    let fiyat: Double
    let gorselAdi: String
    var adet: Int
}

struct sepetView: View {
    @State private var sepet: [SepetUrun] = [
        SepetUrun(urunAdi: "T-Shirt", fiyat: 199.99, gorselAdi: "tshirt", adet: 1),
        SepetUrun(urunAdi: "Sneaker", fiyat: 599.50, gorselAdi: "sneaker", adet: 2)
    ]
    
    @State private var showingConfirmation = false
    
    var toplamFiyat: Double {
        sepet.reduce(0) { $0 + ($1.fiyat * Double($1.adet)) }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Sepetim")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                List {
                    ForEach($sepet) { $urun in
                        HStack(spacing: 15) {
                            Image(urun.gorselAdi)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)

                            VStack(alignment: .leading) {
                                Text(urun.urunAdi)
                                    .font(.headline)

                                Text(String(format: "%.2f TL", urun.fiyat))
                                    .foregroundColor(.gray)

                                HStack {
                                    Button {
                                        withAnimation {
                                            urunAzalt(urun: urun)
                                        }
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(urun.adet > 1 ? .red : .gray)
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    Text("\(urun.adet)")
                                        .frame(minWidth: 30)
                                        .padding(.horizontal, 8)
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(5)

                                    Button {
                                        withAnimation {
                                            urunArttir(urun: urun)
                                        }
                                    } label: {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.green)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding(.vertical, 4)
                            }
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    urunuSil(urun: urun)
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())

                VStack(spacing: 10) {
                    HStack {
                        Text("Toplam:")
                            .font(.headline)
                        Spacer()
                        Text(String(format: "%.2f TL", toplamFiyat))
                            .font(.headline)
                            .bold()
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: OdemeView(toplamTutar: toplamFiyat)) {
                        Text("Onayla ve Öde")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.bottom, 20)
            }
            .alert("Ödeme Onaylandı", isPresented: $showingConfirmation) {
                Button("Tamam", role: .cancel) { }
            } message: {
                Text("Toplam \(String(format: "%.2f TL", toplamFiyat)) tutarındaki siparişiniz onaylandı.")
            }
        }
    }
    
    // MARK: - Sepet İşlem Fonksiyonları
    
    func urunArttir(urun: SepetUrun) {
        if let index = sepet.firstIndex(where: { $0.id == urun.id }) {
            sepet[index].adet += 1
        }
    }
    
    func urunAzalt(urun: SepetUrun) {
        if let index = sepet.firstIndex(where: { $0.id == urun.id }) {
            if sepet[index].adet > 1 {
                sepet[index].adet -= 1
            }
        }
    }
    
    func urunuSil(urun: SepetUrun) {
        if let index = sepet.firstIndex(where: { $0.id == urun.id }) {
            withAnimation {
                sepet.remove(at: index)
            }
        }
    }
}

struct sepetView_Previews: PreviewProvider {
    static var previews: some View {
        sepetView()
    }
}

