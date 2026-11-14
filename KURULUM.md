# Samsung Smart Monitor için reklamsız ana ekran — kurulum

Samsung'un Tizen sistemi, kendi ana ekranının (Smart Hub) yerine başka bir ekran koymaya izin vermez.
Bu yüzden iki şeyi birlikte yapıyoruz:

1. Samsung'un kendi reklamlarını ve otomatik açılan Smart Hub'ı **kapatmak**
2. Kendi minimal ana ekranımızı (`index.html`) monitörde **tek tıkla açılır** hale getirmek

> Menü adları modele ve yazılım sürümüne göre biraz farklı olabilir. Tam yolu bulamazsan
> Ayarlar içindeki arama kutusunu kullan.

---

## 1. Samsung reklamlarını azalt

**Ayarlar → Tüm Ayarlar → Genel ve Gizlilik** altında:

| Ayar | Değer |
|---|---|
| Başlangıç Ekranı Seçeneği → **Smart Hub'ı Otomatik Başlat** | Kapalı |
| Şartlar ve Gizlilik → Gizlilik Seçenekleri → **İlgi Alanına Dayalı Reklamlar** | Kapalı |
| Şartlar ve Gizlilik → Gizlilik Seçenekleri → **Görüntüleme Bilgisi Hizmetleri** | Kapalı |
| Şartlar ve Gizlilik → **Ses tanıma / pazarlama** onayları | İstemiyorsan geri çek |

Ana ekrandaki istemediğin uygulama kutucuklarını da kaldırabilirsin: kutucuğun üzerine gel →
kumandada **Aşağı** → **Kaldır** (ya da **Taşı**).

## 2. (İsteğe bağlı) DNS ile reklam sunucularını engelle

Bu yöntem Samsung'un reklam ve takip sunucularının çoğunu ağ seviyesinde engeller.

**Ayarlar → Genel ve Gizlilik → Ağ → Ağ Durumu → IP Ayarları → DNS Ayarı → Manuel Gir**

- DNS: `94.140.14.14` (AdGuard DNS, ücretsiz)

Bir uygulama düzgün çalışmazsa DNS ayarını tekrar **Otomatik**'e almak yeterli.
Evdeki tüm cihazlar için yapmak istersen aynı DNS'i modem ayarlarına da girebilirsin.

## 3. Ana ekranı yayınla

Monitörün sayfayı açabilmesi için sayfanın bir internet adresi olmalı.

**Hızlı deneme (bugün):** Mac'te önizleme sunucusu açıkken monitörün **Internet** uygulamasında
şu adresi aç: `http://192.168.1.19:8080`
(Mac ve monitör aynı Wi-Fi'da olmalı. Mac kapanınca sayfa da açılmaz; macOS güvenlik duvarı
izin isterse "İzin ver" de.)

**Kalıcı (önerilen):** Klasörü ücretsiz bir barındırma hizmetine koy:

- **Netlify Drop:** `app.netlify.com/drop` adresine bu klasörü sürükle bırak → ücretsiz hesapla
  kalıcı bir adres alırsın (ör. `benim-ekranim.netlify.app`).
- **GitHub Pages:** `index.html`'i bir depoya yükle, Settings → Pages'i aç.

## 4. Monitörde ayarla

1. **Internet** uygulamasını aç, sayfanın adresine git.
2. Tarayıcı ayarlarından bu sayfayı **ana sayfa / başlangıç sayfası** yap.
3. Ana ekranın uygulama satırında **Internet**'in üzerine gel → **Aşağı** → **Taşı** → en başa al.
   Artık monitörü açınca tek tıkla kendi ekranına gelirsin.
4. İstersen **Genel ve Gizlilik → Başlangıç Ekranı Seçeneği → Son Uygulamayı Otomatik Başlat**'ı
   aç; monitör son açık kalan Internet uygulamasıyla (yani senin ekranınla) başlar.

**Kumanda:** ok tuşları kutucuklar arasında gezer, OK açar, Geri ayarlar panelini kapatır.
Tarayıcı imleç modundaysa kutucuklara doğrudan tıklayabilirsin.

## 5. Ekran ve özellikler

**Ana ekran:** solda büyük saat; yanında tarih, hava durumu, hava kalitesi ve dönen bir **akıllı özet**
satırı (yağmur ne zaman başlayıp dinecek, gün batımı, yaklaşan resmî tatil, Dolar/Euro kuru).
Odaklanılan uygulamanın adı büyük yazıyla görünür, arka plan o uygulamanın renginde parlar. Altta
dock (favoriler), onun altında tüm uygulamalar; kutucuklarda uygulamaların logoları var. Listeye
inince saat yerinde kalır, uygulamalar yukarı kayar. Kumanda: ok tuşları gezer, OK açar, **OK'u
basılı tutmak** seçenekleri açar (dock'a ekle, taşı, kaldır), Geri bir üst seviyeye döner.

**Üstteki düğmeler:** Girişler (HDMI listesi), Ağ (ağ adı, IP adresi), Ayarlar.

**Akıllı özellikler:**
- Hangi saatte hangi uygulamayı açtığını yalnızca bu cihazda öğrenir, o saatte onu öne çıkarır
- Monitöre HDMI cihazı takılınca "Bu girişe geç" önerir (yalnızca Tizen uygulamasında)
- Otomatik tema: gün doğumunda açık, gün batımında koyu

**Ayarlar sayfası:**
- **Görünüm:** Otomatik / Açık / Koyu / Siyah, 24 saat, Hareketi azalt, Gerçek cam bulanıklığı
- **Arka plan:** Akıllı (günün saatine ve havaya göre renk değiştirir), Şafak, Okyanus, Gün batımı, Orman, Günün fotoğrafı (Wikimedia, her gün değişir), **Gece fotoğrafları** (12 koyu fotoğraf: kuzey ışıkları, Samanyolu, nebulalar, gece şehirleri; birini seç ya da "Her gün farklı"; bu arka planda tema hep koyu kalır) ya da kendi görselin
- **Ekran koruyucu:** Akıllı (gündüz fotoğraflar, 23:00–06:00 karanlık saat), Saat, Aurora, Fotoğraflar, Gece; başlama süresi (Kapalı / 1 / 3 / 5 / 10 dk); Şimdi önizle
- **Bilgiler:** hava durumu şehri, hava kalitesi, döviz, akıllı öneriler
- **Kısayollar:** web sitesi kısayolu ekle
- **Cihaz:** model, yazılım, IP; Samsung ayarlarını aç; varsayılanlara dön

Ayarlar o cihazda saklanır.

### Senin monitörün: Smart Monitor M5 32" (LS32AM500, 2021)

- 2021 modeli olduğu için tarayıcı motoru eski. Kod buna göre yazıldı (eski JavaScript sözdizimi,
  yeni CSS özellikleri yok).
- **Gerçek cam bulanıklığı'nı kapalı tut** (varsayılan kapalı). Cam görünümü bulanıklık olmadan
  da taklit ediliyor; bu modelde bulanıklık yavaş çalışabilir ya da hiç görünmeyebilir.
- Animasyonlar takılırsa önce **Hareketli arka plan**'ı kapat.

---

## Seçenek B: Gerçek uygulama olarak kurulum (Tizen .wgt)

Tarayıcıda kutucuklar uygulamaların **web sitelerini** açar; Netflix gibi servisler TV tarayıcısında
video oynatmayabilir. Ekranı bir **Tizen uygulaması** olarak kurunca tarayıcı çubuğu olmadan tam ekran
açılır ve kutucuklar **gerçek YouTube/Netflix uygulamalarını** başlatır (kod buna hazır).

**VS Code + Tizen eklentisi şart değil.** Videoda kolaylık için kullanılıyor. Asıl gereken şeyler
Samsung'un komut satırı araçları ve bir Samsung sertifikası; bunları terminalden kurup
çalıştırabilirim.

### Durum (14 Kasım)

| Adım | Durum |
|---|---|
| Mac'e Tizen komut satırı araçları, Samsung Certificate Extension, Certificate Manager | ✅ Kuruldu (`~/tizen-studio`) |
| Uygulama klasörü: `tizen/config.xml`, `tizen/icon.png` | ✅ Hazır |
| Paketleme | ✅ Geçici test sertifikasıyla denendi, imzalı `.wgt` oluştu |
| Tek komutluk kurulum betiği `tizen/kur.sh` | ✅ Hazır |
| Monitör ağda (`192.168.1.6`, LS32AM500NMXUF, Tizen 5.5) | ✅ Bulundu |
| Monitörde Geliştirici Modu (Ana bilgisayar IP'si `192.168.1.19`) | ✅ Açık |
| Samsung sertifikası (`samsung-m5` profili) | ✅ Oluşturuldu |
| Monitöre yükleme | ✅ **Kuruldu ve çalışıyor** ("Ana Ekran", `AnaEkranTV.Home`) |

**Hafif mod:** monitörün işlemcisi zayıf olduğu için uygulama orada kendiliğinden hafif modda açılır:
arka plan sabit, gölgeler sade, açılış animasyonları kapalı. Ayarlar → Görünüm → Hafif mod'dan
değiştirilebilir.

**Güncelleme:** `index.html`'de değişiklik yapınca `./tizen/kur.sh 192.168.1.6` aynı adla üstüne kurar
(ayarlar korunur). Mac'in IP'si değişirse monitördeki Geliştirici Modu IP'sini de güncellemek gerekir.

### İlk kurulum adımları (yapıldı, kayıt için)

**1. Monitörde Geliştirici Modu'nu aç**
- Kumandada **Home** → **Uygulamalar** ekranı.
- Orada sırayla **1 2 3 4 5** bas (rakam tuşu yoksa **123** tuşuyla ekrandaki tuş takımını aç).
- **Geliştirici modu: Açık**, **Ana bilgisayar IP'si: `192.168.1.19`** → **Tamam**.
- Monitörü **fişten çekip 30 saniye bekle**, sonra aç.

**2. Samsung sertifikasını oluştur** (monitör bağlıyken)
- Mac'te `~/tizen-studio/tools/certificate-manager/Certificate-manager.app`'i aç.
- **+** → **Samsung** → cihaz türü **TV** → profil adı: **`samsung-m5`**.
- **Create a new author certificate**: bir ad ve kendi belirlediğin bir şifre gir (unutma).
- Açılan tarayıcıda **Samsung hesabınla giriş yap**.
- Distributor sertifikası adımında monitörün **DUID**'i otomatik gelir (gelmezse `tizen/kur.sh 192.168.1.6 --duid`
  komutunun yazdığını gir) → **Finish**.

**3. Yükle**

Bana "kur" de, ben çalıştırırım; ya da bu klasörde kendin çalıştır:

```bash
./tizen/kur.sh 192.168.1.6
```

Betik bağlanır, paketler, imzalar, yükler ve başlatır.
Ana ekranda sonradan değişiklik yaparsan aynı komutu tekrar çalıştırman yeterli.

Logolar: vektörler [Simple Icons](https://simpleicons.org)'tan (CC0); Disney+ ve TOD ikonları kendi
sitelerinden. Exxen ve tabii için yüksek çözünürlüklü logo bulunamadı, adları marka renginde yazılıyor.
Akıllı özetteki resmî tatiller [Nager.Date](https://date.nager.at)'ten (ücretsiz, anahtar gerekmez).
Gece fotoğrafları Wikimedia Commons'ın seçkin fotoğraflarından; çoğu CC BY / CC BY-SA lisanslı, fotoğrafçı
ve lisans Ayarlar → Arka plan'da fotoğrafın altında yazar.

Kurulumdan sonra monitörde kontrol edilecekler: uygulama listesi geliyor mu, YouTube/Netflix kutucukları
gerçek uygulamaları açıyor mu, HDMI listesi ve kumanda Geri tuşu çalışıyor mu.

**Home tuşu:** Kumandadaki Home tuşunu bu ekrana bağlamak resmi olarak desteklenmiyor ve riskli.
Bunun yerine uygulamayı uygulama satırının en başına al ve **Son Uygulamayı Otomatik Başlat**
ayarını aç. Her şeyi geri almak için uygulamayı kaldırıp Geliştirici Modu'nu kapatman yeterli.

Referans: [CleanFrame](https://github.com/nthnclrk/CleanFrame), Samsung The Frame için aynı yöntemle
yapılmış açık kaynak bir ana ekran.
