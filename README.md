# AOE3:DE – Middle Mouse Drag-to-Pan (AutoHotkey)

🎮 **Age of Empires III: Definitive Edition** içinde **orta tuşa (MMB) basılı tutup fareyi sürükleyerek kamera kaydırma** özelliğini ekleyen küçük bir AutoHotkey aracı.

- ✅ Fullscreen ve Borderless modlarda çalışır  
- ✅ Hem **AHK v1** hem **AHK v2** uyumlu sürümler mevcut  
- ✅ Sadece klavye tuşlarını simüle eder, oyun dosyalarını değiştirmez  

---

## 📦 Dosyalar

| Dosya | Açıklama |
|-------|----------|
| `src/aoe3_mmb_drag_sc_v1.ahk` | **AHK v1 sürümü (önerilen)** – fullscreen’de en stabil |
| `src/aoe3_mmb_drag_sc_v2.ahk` | **AHK v2 sürümü** – modern sözdizimi, hold/release uyumlu |

---

## 🚀 Kullanım

### 1. Gereksinimler
- Windows 10/11  
- [AutoHotkey](https://www.autohotkey.com/) (v1 veya v2, hangi sürümü kullanmak istiyorsanız)  

### 2. Oyunda yapılması gerekenler
- Kamera kaydırma tuşlarını **Ok tuşları** (veya WASD) olarak atayın.  
- Çakışma yaşıyorsanız **edge pan**’i kapatın.  
- Oyunu **Yönetici** çalıştırıyorsanız, betiği de **Yönetici** çalıştırın.  

### 3. Betiği çalıştırma
- `.ahk` dosyasına çift tıkla → simge tray’de çıkar.  
- `F8` → Betiği aç/kapat (toggle)  
- **Orta tuş (MMB)** basılı tut, fareyi sürükle → kamera kayar.  

---

## ⚙️ Ayarlar

Betiğin başındaki değişkenleri düzenleyerek davranışı değiştirebilirsiniz:

- `UseArrows := true` → **true:** ok tuşlarını gönderir, **false:** WASD gönderir  
- `Deadzone := 3` → küçük titremeleri yok sayma eşiği (piksel)  
- `ThreshX / ThreshY` → yön kararı için piksel eşiği  
- `InvertX / InvertY` → eksenleri ters çevir  

---

## 🔨 EXE’ye Derleme (opsiyonel)

Eğer `.exe` halinde çalıştırmak isterseniz:  

- **AHK v1 için:** Ahk2Exe (v1) kullanarak `src/aoe3_mmb_drag_sc_v1.ahk`’yi derleyin.  
- **AHK v2 için:** AHK v2’nin kendi Ahk2Exe’sini kullanarak `src/aoe3_mmb_drag_sc_v2.ahk`’yi derleyin.  
- Derleyici seçerken başlık çubuğunda doğru sürümün yazdığından emin olun (v1 / v2).  

---

## ❓ SSS

**Tam ekranda neden v1 daha iyi çalışıyor?**  
Çünkü v1 sürümü `scan code + hold/release` yöntemiyle gerçek klavye basışlarını taklit eder. Oyun bunu her zaman algılar.

**Anti-cheat riski var mı?**  
Hayır. Bu betik sadece tuş gönderir, oyun dosyalarına veya belleğe dokunmaz. Ama yine de çevrimiçi oyunlarda üçüncü taraf yazılım politikaları sunucuya göre değişebilir.

**MMB yerine farklı tuş atayabilir miyim?**  
Evet. `*MButton::` ve `*MButton Up::` kısımlarını istediğiniz tuşla değiştirebilirsiniz (ör. `XButton1`).  

---

## 🤝 Katkı
- Hatalar için **Issues** açabilirsiniz.  
- Yeni özellik / geliştirme önerileri için **Pull Request** atabilirsiniz.  

---

## 📜 Lisans
MIT License – ayrıntı için [LICENSE](LICENSE) dosyasına bakınız.
