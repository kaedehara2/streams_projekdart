# stream_ghazilov
Projek Flutter Baru (PojokSoal)

## SOAL 1 PRAKTIKUM 1: DART STREAMS

- Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.
- Gantilah warna tema aplikasi sesuai kesukaan Anda.
- Lakukan commit hasil jawaban Soal 1 dengan pesan "P1: Jawaban Soal 1"

JAWABAN

1. Untuk nama panggilan sudah dirubah dan ditambahkan pada bagian title sebagai identitas projek yang saat ini dikerjakan
![SSTUGAS](assets/sstugas1.png)

2. Commit Done

## SOAL 2 PRAKTIKUM 1: DART STREAMS

- Tambahkan 5 warna lainnya sesuai keinginan Anda pada variabel colors tersebut
- Lakukan commit hasil jawaban Soal 2 dengan pesan "P1: Jawaban Soal 2"

JAWABAN

1. Saya telah menambahkan beberapa warna yang berbeda didalam setiap entity, berikut saya sertakan hasil screenshotnya 
![SSTUGAS](assets/sstugas2.png)

2. Commit Done

## SOAL 3 PRAKTIKUM 1: DART STREAMS

- Jelaskan fungsi keyword yield* pada kode tersebut!
- Apa maksud isi perintah kode tersebut?
- Lakukan commit hasil jawaban Soal 3 dengan pesan "P1: Jawaban Soal 3"

JAWABAN

1. Keyword yield* digunakan untuk menyebarkan atau meneruskan seluruh nilai dari stream lain ke dalam stream saat ini. Dalam kode tersebut, yield* meneruskan semua nilai dari Stream.periodic, yang menghasilkan nilai baru setiap satu detik. Setiap nilai yang dihasilkan adalah warna dari daftar colors, dengan indeks yang berubah-ubah mengikuti waktu (t). Jadi, fungsi getColors() akan terus mengeluarkan warna secara bergantian setiap detik dari daftar colors melalui stream.

2. Commit Done

## SOAL 4 PRAKTIKUM 1: DART STREAMS

- Capture hasil praktikum Anda berupa GIF dan lampirkan di README.
- Lakukan commit hasil jawaban Soal 4 dengan pesan "P1: Jawaban Soal 4

JAWABAN

1. Hasil Screen capture
![GIF](screencapture/hasilgif1.gif)

2. Commit Done

## SOAL 5 PRAKTIKUM 1: DART STREAMS

- Jelaskan perbedaan menggunakan listen dan await for (langkah 9) !
- Lakukan commit hasil jawaban Soal 5 dengan pesan "P1: Jawaban Soal 5"

JAWABAN

1. Perbedaan antara listen dan await for dalam konteks Stream terletak pada cara keduanya mengakses dan mengelola data stream:
- await for hanya bisa digunakan dalam fungsi async dan menunggu setiap data dari stream secara berurutan dan sinkron. Artinya, proses akan berhenti sementara sampai data baru diterima dari stream berikutnya. Cocok digunakan jika kamu ingin menunggu satu per satu data secara teratur atau menghentikan stream di tengah jalan menggunakan break.
- Sedangkan listen akan langsung berlangganan ke stream dan mendengarkan semua data yang masuk secara asinkron tanpa menghentikan eksekusi kode lainnya. listen juga memberikan lebih banyak fleksibilitas karena mendukung parameter tambahan seperti onDone, onError, dan cancelOnError.

2. Commit Done

## SOAL 6 PRAKTIKUM 2: STREAM CONTROLLERS & SINKS

- Jelaskan maksud kode langkah 8 dan 10 tersebut!
- Capture hasil praktikum Anda berupa GIF dan lampirkan di README.
- Lalu lakukan commit dengan pesan "P2: Jawaban Soal 6".

JAWABAN

1. Langkah 8-initState()

```kotlin
@override
void initState() {
  numberStream = NumberStream();
  numberStreamController = numberStream.controller;
  Stream stream = numberStreamController.stream;
  stream.listen((event) {
    setState(() {
      lastNumber = event;
    });
  });
  super.initState();
}
```
 Penjelasan:

- Fungsi initState() dijalankan sekali saat pertama kali StatefulWidget dibangun.
- numberStream = NumberStream();
➤ Membuat objek dari kelas NumberStream yang berisi StreamController.

- numberStreamController = numberStream.controller;
➤ Mengakses controller dari objek NumberStream dan menyimpannya ke dalam variabel.

- Stream stream = numberStreamController.stream;
➤ Mengambil stream dari controller untuk didengarkan perubahannya.

- stream.listen(...)
➤ Mendengarkan data yang masuk ke stream, dan setiap ada data baru (event), maka:
    - Fungsi setState dipanggil untuk memperbarui nilai lastNumber di UI.
    - UI akan langsung merespons perubahan tersebut.

langkah 10-addRandomNumber()
```kotlin
  void addRandomNumber() {
  Random random = Random();
  int MyNum = random.nextInt(10);
  numberStream.addNumberToSink(MyNum);
}
```
Penjelasan:
- Fungsi ini digunakan untuk menghasilkan angka acak dari 0 sampai 9.
- Random random = Random();
➤ Membuat objek acak.

- int MyNum = random.nextInt(10);
➤ Menghasilkan angka acak antara 0 sampai 9.

- numberStream.addNumberToSink(MyNum);
➤ Mengirim angka tersebut ke stream menggunakan method addNumberToSink() (yang seharusnya sudah didefinisikan di dalam kelas NumberStream). ➤ Setelah angka terkirim ke stream, fungsi listen di langkah 8 akan menangkapnya dan memperbarui tampilan UI.

Hubungan Langkah 8 dan 10:
- Langkah 8 menyambungkan stream dengan UI agar bisa menampilkan data baru.
- Langkah 10 mengirim data baru (angka acak) ke stream.
- Ketika data dikirim melalui langkah 10, maka UI otomatis merespons karena sudah "mendengarkan" dari langkah 8

2. Hasil Screen capture
![GIF](screencapture/hasilgif2.gif)

3. Commit Done

## SOAL 7 PRAKTIKUM 2 :STREAM CONTROLLERS & SINKS

- Jelaskan maksud kode langkah 13 sampai 15 tersebut!
- Kembalikan kode seperti semula pada Langkah 15, comment addError() agar Anda dapat melanjutkan ke praktikum 3 berikutnya.
- Lalu lakukan commit dengan pesan "P2: Jawaban Soal 7".

JAWABAN

1. Langkah 13-addError()
```kotlin
addError() {
  controller.sink.addError('error');
}
```
Penjelasan
- Fungsi addError() digunakan untuk mengirim error ke dalam stream.
- controller.sink.addError('error'); akan memicu stream menghasilkan error dengan pesan 'error'.
- Ini akan ditangkap oleh listener yang mendengarkan error di langkah 14

Langkah 14-Menangani Error di listener
```kotlin
}).onError((error){
  setState(() {
    lastNumber = -1;
  });
});
```
Penjelasan
- Bagian ini adalah penanganan error (onError) pada stream listener.
- Ketika ada error yang masuk (dari addError() tadi), maka blok ini akan dijalankan.
- Di dalam setState, lastNumber diubah menjadi -1 sebagai indikator bahwa terjadi error.
- UI kemudian akan menampilkan angka -1 sebagai tanda ada kesalahan (misalnya ketika pengguna menekan tombol error).

Langkah 15-Memodifikasi addRandomNumber() untuk Uji Error
```kotlin
void addRandomNumber() {
  Random random = Random();
  //int MyNum = random.nextInt(10);
  //numberStream.addNumberToSink(MyNum);
  numberStream.addError();
}
```
Penjelasan
- Di langkah ini, fungsi addRandomNumber() tidak lagi menghasilkan angka acak.
- Sebagai gantinya, ia mengirim error ke stream dengan memanggil numberStream.addError().
- Ini akan langsung memicu bagian onError di langkah 14 dan membuat lastNumber menjadi -1

Kesimpulan
Langkah 13 hingga 15 digunakan untuk mengimplementasikan dan menguji penanganan error pada stream. Error dikirim menggunakan addError(), lalu ditangani melalui listener onError(), dan hasilnya akan ditampilkan dengan mengubah nilai lastNumber menjadi -1 sebagai indikator bahwa error telah terjadi. Ini penting agar aplikasi tetap stabil meskipun terjadi kesalahan dalam aliran data.

2. 
![SSTUGAS](assets/sstugas3.png)
commit done