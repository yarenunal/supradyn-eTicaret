import SwiftUI

struct GirisView: View {
    @State private var girisYontemi: GirisYontemi = .eposta
    @State private var eposta: String = ""
    @State private var telefon: String = ""
    @State private var sifre: String = ""
    @State private var girisBasarili: Bool = false

    enum GirisYontemi: String, CaseIterable {
        case eposta = "E-posta"
        case telefon = "Telefon"
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Giriş Yap")
                    .font(.largeTitle.bold())
                    .padding(.top, 40)

                Picker("Giriş Yöntemi", selection: $girisYontemi) {
                    ForEach(GirisYontemi.allCases, id: \.self) { yontem in
                        Text(yontem.rawValue).tag(yontem)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                if girisYontemi == .eposta {
                    TextField("E-posta", text: $eposta)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                } else {
                    TextField("Telefon Numarası", text: $telefon)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }

                SecureField("Şifre", text: $sifre)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                NavigationLink(destination: MainTabView(), isActive: $girisBasarili) {
                    EmptyView()
                }

                Button(action: {
                    // Burada giriş kontrolü yapabilirsin
                    girisBasarili = true
                }) {
                    Text("Giriş Yap")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()

                HStack {
                    Text("Hesabınız yok mu?")
                        .font(.footnote)
                    NavigationLink(destination: KayitOlView()) {
                        Text("Kayıt Ol")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

struct KayitOlView: View {
    @State private var kayitYontemi: GirisView.GirisYontemi = .eposta
    @State private var eposta: String = ""
    @State private var telefon: String = ""
    @State private var sifre: String = ""
    @State private var kayitBasarili: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            Text("Kayıt Ol")
                .font(.largeTitle.bold())
                .padding(.top, 40)

            Picker("Kayıt Yöntemi", selection: $kayitYontemi) {
                ForEach(GirisView.GirisYontemi.allCases, id: \.self) { yontem in
                    Text(yontem.rawValue).tag(yontem)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            if kayitYontemi == .eposta {
                TextField("E-posta", text: $eposta)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
            } else {
                TextField("Telefon Numarası", text: $telefon)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
            }

            SecureField("Şifre", text: $sifre)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            NavigationLink(destination: MainTabView(), isActive: $kayitBasarili) {
                EmptyView()
            }

            Button(action: {
                // Burada kayıt kontrolü yapılabilir
                kayitBasarili = true
            }) {
                Text("Kayıt Ol")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
    }
}

struct anasayfaView: View {
    var body: some View {
        AnasayfaView()
    }
}

struct mainTabView: View {  // MainTabView olarak değiştirdik
    var body: some View {
        TabView {
            AnasayfaView()  // AnasayfaView olarak değiştirdik
                .tabItem {
                    Label("Anasayfa", systemImage: "house")
                }

            Text("Profil")
                .tabItem {
                    Label("Profil", systemImage: "person")
                }
        }
    }
}

#Preview {
    GirisView()
}
