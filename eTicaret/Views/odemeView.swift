import SwiftUI

struct OdemeView: View {
    var toplamTutar: Double
    
    @State private var adres: String = ""
    @State private var secilenOdemeYontemi: String = "Kapıda Ödeme"
    @State private var odemeBasari: Bool = false
    
    let odemeSecenekleri = ["Kapıda Ödeme", "Kartla Ödeme"]

    var body: some View {
        VStack {
            Text("Ödeme Sayfası")
                .font(.largeTitle)
                .bold()
                .padding()
            
            // Adres Bilgileri
            VStack(alignment: .leading, spacing: 10) {
                Text("Adres Bilgilerinizi Girin:")
                    .font(.headline)
                
                TextField("Adresinizi buraya yazın...", text: $adres)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
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
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
            
            // Toplam Tutar
            Text("Ödemeniz gereken tutar: \(String(format: "%.2f TL", toplamTutar))")
                .font(.title)
                .padding(.bottom, 20)
            
            // Ödeme Tamamlama Butonu
            Button(action: {
                if !adres.isEmpty {
                    // Burada ödeme işlemini başlatıyoruz (simülasyon)
                    odemeBasari = true
                } else {
                    odemeBasari = false
                }
            }) {
                Text("Ödemeyi Tamamla")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            // Ödeme Başarısı Mesajı
            if odemeBasari {
                Text("Güvenli Ödeme Gerçekleşti!")
                    .font(.title2)
                    .foregroundColor(.green)
                    .bold()
                    .padding(.top, 20)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(false)
    }
}

struct OdemeView_Previews: PreviewProvider {
    static var previews: some View {
        OdemeView(toplamTutar: 799.99)
    }
}

