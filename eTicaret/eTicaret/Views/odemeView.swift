import SwiftUI

struct OdemeView: View {
    var toplamTutar: Double
    
    @State private var adres: String = ""
    @State private var secilenOdemeYontemi: String = "Kapıda Ödeme"
    @State private var odemeBasari: Bool = false
    
    // Kart Bilgileri
    @State private var kartNumarasi: String = ""
    @State private var sonKullanmaTarihi: String = ""
    @State private var ccv: String = ""
    
    let odemeSecenekleri = ["Kapıda Ödeme", "Kartla Ödeme"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Ödeme Sayfası")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                
                // Adres Bilgileri
                VStack(alignment: .leading, spacing: 10) {
                    Text("Adres Bilgilerinizi Girin:")
                        .font(.headline)
                    
                    TextField("Adresinizi buraya yazın...", text: $adres)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.bottom, 20)
                
                // Ödeme Yöntemi Seçimi
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ödeme Yöntemi Seçin:")
                        .font(.headline)
                    
                    Picker("Ödeme Yöntemi", selection: $secilenOdemeYontemi) {
                        ForEach(odemeSecenekleri, id: \.self) { secenek in
                            Text(secenek)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.bottom, 20)
                
                // Kart Bilgileri (Sadece Kartla Ödeme Seçilirse Gösterilir)
                if secilenOdemeYontemi == "Kartla Ödeme" {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Kart Bilgileri:")
                            .font(.headline)
                        
                        TextField("Kart Numarası", text: $kartNumarasi)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Son Kullanma Tarihi (AA/YY)", text: $sonKullanmaTarihi)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("CCV", text: $ccv)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.bottom, 20)
                }
                
                // Toplam Tutar
                Text("Ödemeniz gereken tutar: \(String(format: "%.2f TL", toplamTutar))")
                    .font(.title)
                    .padding(.bottom, 20)
                
                // Ödeme Tamamlama Butonu
                Button(action: {
                    if adres.isEmpty {
                        odemeBasari = false
                        return
                    }
                    
                    if secilenOdemeYontemi == "Kartla Ödeme" {
                        if kartNumarasi.isEmpty || sonKullanmaTarihi.isEmpty || ccv.isEmpty {
                            odemeBasari = false
                            return
                        }
                    }
                    
                    // Ödeme başarılı (simülasyon)
                    odemeBasari = true
                }) {
                    Text("Ödemeyi Tamamla")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.bottom, 10)
                
                // Ödeme Başarısı Mesajı
                if odemeBasari {
                    Text("Güvenli Ödeme Gerçekleşti!")
                        .font(.title2)
                        .foregroundColor(.green)
                        .bold()
                        .padding(.top, 10)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(false)
    }
}

struct OdemeView_Previews: PreviewProvider {
    static var previews: some View {
        OdemeView(toplamTutar: 799.99)
    }
}

