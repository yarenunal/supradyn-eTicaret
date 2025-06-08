import SwiftUI
import UserNotifications

struct Siparis: Identifiable {
    let id = UUID()
    let urunAdi: String
    let fiyat: Double
    let gorselAdi: String // Assets içindeki görsel adı
}

struct profilView: View {
    
    let siparisler: [Siparis] = [
        Siparis(urunAdi: "Kırmızı Elbise", fiyat: 499.99, gorselAdi: "elbise"),
        Siparis(urunAdi: "Spor Ayakkabı", fiyat: 799.50, gorselAdi: "ayakkabi"),
        Siparis(urunAdi: "Deri Cüzdan", fiyat: 259.00, gorselAdi: "cuzdan")
    ]
    
    @State private var bildirimAktif: Bool = false
    
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

                // 📣 Toggle ile bildirim
                Toggle(isOn: $bildirimAktif) {
                    Text("Bildirimleri Aç")
                        .fontWeight(.medium)
                }
                .padding()
                .onChange(of: bildirimAktif) { yeniDurum in
                    if yeniDurum {
                        requestNotificationPermission()
                        scheduleLocalNotification()
                    }
                }

                // 🔒 Çıkış butonu
                Button(action: {
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

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Bildirim izni verildi.")
            } else if let error = error {
                print("Bildirim izni hatası: \(error.localizedDescription)")
            }
        }
    }

    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Bildirim Açıldı"
        content.body = "Sipariş bildirimleri artık açık!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}

#Preview {
    profilView()
}

