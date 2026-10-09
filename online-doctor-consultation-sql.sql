CREATE DATABASE CareConnect;
USE CareConnect;

CREATE TABLE MsApotek(
IDApotek CHAR(4) PRIMARY KEY CHECK (IDApotek REGEXP '^A[0-9]{3}$'),
NamaApotek VARCHAR(255) NOT NULL,
AlamatApotek VARCHAR(255) NOT NULL
);


CREATE TABLE MsRumahSakit(
IDRumahSakit CHAR(7) PRIMARY KEY CHECK (IDRumahSakit REGEXP '^[A-Z]{3}-[0-9]{3}$'),
NamaRumahSakit VARCHAR(255) NOT NULL
);


CREATE TABLE MsPengiriman(
NomorResi CHAR(6) PRIMARY KEY CHECK (NomorResi REGEXP '^RS[0-9]{3}A$'),
IdentitasDriver VARCHAR(255) NOT NULL,
StatusPengiriman VARCHAR(10) NOT NULL
);

CREATE TABLE MsCustomer(
IDCustomer CHAR(4) PRIMARY KEY CHECK (IDCustomer REGEXP '^C[0-9]{3}$'),
NamaCustomer VARCHAR(255) NOT NULL,
Gender VARCHAR(10) NOT NULL,
TanggalLahir DATE NOT NULL,
Alamat VARCHAR(255) NOT NULL,
Email VARCHAR(50) NOT NULL UNIQUE,
NoHP VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE MsObat(
IDObat CHAR(5) PRIMARY KEY CHECK (IDObat REGEXP '^[A-Z]{2}[0-9]{3}$'),
NamaObat VARCHAR(255) NOT NULL,
HargaObat INT NOT NULL
);


CREATE TABLE MsDokter(
IDDokter CHAR(4) PRIMARY KEY CHECK (IDDokter REGEXP '^D[0-9]{3}$'),
IDRumahSakit CHAR(7) NOT NULL,
NamaDokter VARCHAR(255) NOT NULL,
SpesialisasiDokter VARCHAR(255) NOT NULL,
FOREIGN KEY (IDRumahSakit) REFERENCES MsRumahSakit (IDRumahSakit)
	ON DELETE RESTRICT
    ON UPDATE CASCADE 
);


CREATE TABLE TransactionHeader(
IDTransaksi CHAR(4) PRIMARY KEY CHECK (IDTransaksi REGEXP '^T[0-9]{3}$'),
IDDokter CHAR(4) NOT NULL,
IDCustomer CHAR(4) NOT NULL,
IDApotek CHAR(4) DEFAULT NULL,
NomorResi CHAR(6) DEFAULT NULL,
TanggalTransaksi DATE NOT NULL,
Layanan VARCHAR(50) NOT NULL,
WaktuMulaiKonsultasi TIME NOT NULL,
WaktuSelesaiKonsultasi TIME NOT NULL,
BiayaKonsultasi INT NOT NULL,
MetodeBayar VARCHAR(50) NOT NULL,
StatusBayar VARCHAR(50) NOT NULL,
FOREIGN KEY (IDDokter) REFERENCES MsDokter (IDDokter)
	ON DELETE RESTRICT
    ON UPDATE CASCADE,
FOREIGN KEY (IDCustomer) REFERENCES MsCustomer (IDCustomer)
	ON DELETE RESTRICT
    ON UPDATE CASCADE,
FOREIGN KEY (IDApotek) REFERENCES MsApotek (IDApotek)
	ON DELETE RESTRICT
    ON UPDATE CASCADE,
FOREIGN KEY (NomorResi) REFERENCES MsPengiriman (NomorResi)
	ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE PrescriptionDetail(
IDTransaksi CHAR(4),
IDObat CHAR(5),
Kuantitas VARCHAR(50) NOT NULL,
PRIMARY KEY(IDTransaksi, IDObat),
FOREIGN KEY (IDTransaksi) REFERENCES TransactionHeader (IDTransaksi)
	ON DELETE RESTRICT
    ON UPDATE CASCADE,
FOREIGN KEY (IDObat) REFERENCES MsObat (IDObat)
	ON DELETE RESTRICT
    ON UPDATE CASCADE
);

INSERT INTO MsApotek VALUES 
('A001', 'Apotek Sehat Utama', 'Jln. Kebon Jeruk No. 1'),
('A002', 'Apotek Century', 'Jln. Gatot Subroto No. 5'),
('A003', 'Apotek Kimia Farma', 'Jln. Pahlawan No. 8');

INSERT INTO MsRumahSakit VALUES
('SES-814', 'RS Sehat Sentosa'),
('MEU-229', 'RS Medika Utama'),
('BKA-503', 'RS Bina Karya'),
('PEH-667', 'RS Permata Harapan'),
('ASM-940', 'RS Asri Medistra'),
('MIS-374', 'RS Mitra Sejahtera'),
('CIH-158', 'RS Citra Husada'),
('HRK-254', 'RS Harapan Kami');

INSERT INTO MsPengiriman VALUES
('RS001A', 'Ahmad', 'Selesai'),
('RS002A', 'Budi', 'Selesai'),
('RS003A', 'Ilham', 'Selesai'),
('RS007A', 'Andi', 'Selesai'),
('RS008A', 'Rizky', 'Selesai'),
('RS009A', 'Reza', 'Selesai'),
('RS010A', 'Ali', 'Selesai'),
('RS011A', 'Dede', 'Selesai'),
('RS012A', 'Usman', 'Selesai'),
('RS013A', 'Hidayat', 'Selesai'),
('RS014A', 'Bayu', 'Selesai'),
('RS015A', 'Fikri', 'Selesai'),
('RS016A', 'Fahri', 'Selesai'),
('RS017A', 'Robi', 'Selesai'),
('RS018A', 'Malik', 'Selesai'),
('RS019A', 'Rafi', 'Selesai'),
('RS020A', 'Reyhan', 'Selesai'),
('RS021A', 'Yanto', 'Selesai'),
('RS022A', 'Dodo', 'Selesai'),
('RS023A', 'Dika', 'Selesai'),
('RS024A', 'Radit', 'Selesai'),
('RS025A', 'Alfi', 'Selesai'),
('RS026A', 'Rasya', 'Selesai'),
('RS027A', 'Yuda', 'Selesai'),
('RS028A', 'Ahmad', 'Selesai'),
('RS029A', 'Budi', 'Selesai'),
('RS030A', 'Hidayat', 'Selesai'),
('RS031A', 'Raihan', 'Selesai'),
('RS032A', 'Putra', 'Selesai'),
('RS033A', 'Bara', 'Selesai'),
('RS034A', 'Putra', 'Selesai');

INSERT INTO MsCustomer VALUES
('C001', 'Budi Suryanto', 'M', '1990-09-15', 'Jln. Mawar 5', 'budi@mail.com', '081234567890'),
('C003', 'Jaka Pratama H.', 'M', '1988-11-03', 'Jln. Merpati 7', 'jaka@mail.com', '081398765432'),
('C005', 'Toni Kurniawan', 'M', '1975-03-10', 'Jln. Kenanga 22', 'toni@mail.com', '082187654321'),
('C007', 'Riko Januar', 'M', '1998-08-01', 'Jln. Dahlia 3', 'riko@mail.com', '081976543210'),
('C008', 'Maya Dian', 'F', '1980-12-25', 'Jln. Permai 1A', 'maya@mail.com', '085643210987'),
('C009', 'Fajar Gunawan', 'M', '1991-04-19', 'Jln. Anggrek 6', 'fajar@mail.com', '081130987654'),
('C010', 'Gina M.', 'F', '1970-06-06', 'Jln. Melati 17', 'gina@mail.com', '087765432109'),
('C011', 'Dika Mikhail Gunawan', 'M', '1996-10-29', 'Jln. Cemara 4', 'dika@mail.com', '085890123456'),
('C012', 'Elsa Putri Setiawan', 'F', '2009-01-23', 'Jln. Kamboja 11', 'elsa@mail.com', '081245678901'),
('C013', 'Hadi L.', 'M', '1982-05-18', 'Jln. Siliwangi 2', 'hadi@mail.com', '081356789012'),
('C014', 'Indah Sari Permata', 'F', '1999-09-04', 'Jln. Kartini 15', 'indah@mail.com', '085723456789'),
('C015', 'Kevin P.', 'M', '1998-02-09', 'Jln. Veteran 33', 'kevin@mail.com', '089687654321'),
('C016', 'Laila Mariana D.', 'F', '1994-11-20', 'Jln. Diponegoro 7', 'laila@mail.com', '082132109876'),
('C017', 'Muhammad Miko', 'M', '2002-12-12', 'Jln. Mawar 20', 'miko@mail.com', '087810987654'),
('C018', 'Nanda Kertanegara', 'F', '1989-10-10', 'Jln. Sudirman 3', 'nanda@mail.com', '081965432109'),
('C019', 'Muhammad Okky', 'M', '1972-07-21', 'Jln. Merpati 11', 'oki@mail.com', '085609876543'),
('C020', 'Putri Gianti', 'F', '2001-04-02', 'Jln. Pelita 25', 'putri@mail.com', '081176543210'),
('C021', 'Rian H.', 'M', '1976-06-17', 'Jln. Kenanga 30', 'rian@mail.com', '087732109876'),
('C022', 'Siska Jesslyn K.', 'F', '1997-01-26', 'Jln. Gajah Mada 14', 'siska@mail.com', '085898765432'),
('C023', 'Umar K.', 'M', '1992-08-22', 'Jln. Dahlia 8', 'umar@mail.com', '081209876543'),
('C024', 'Vina Shania F.', 'F', '1981-12-08', 'Jln. Permai 5B', 'vina@mail.com', '081321098765'),
('C025', 'Wira Mariadi', 'M', '1999-04-11', 'Jln. Anggrek 1', 'wira@mail.com', '085789012345'),
('C026', 'Yuni Novita', 'F', '1971-06-25', 'Jln. Melati 9', 'yuni.novita@mail.com', '089643210987'),
('C027', 'Zaki Oktavianus', 'M', '1995-10-07', 'Jln. Cemara 16', 'zaki@mail.com', '082176543210'),
('C028', 'Alya P.', 'F', '1984-01-30', 'Jln. Kamboja 21', 'alya@mail.com', '087854321098'),
('C029', 'Muhammad Bambang', 'M', '1983-05-05', 'Jln. Siliwangi 12', 'bambang@mail.com', '081932109876'),
('C030', 'Cici R.', 'F', '2000-09-29', 'Jln. Kartini 8', 'cici@mail.com', '085678901234'),
('C031', 'Jessica Liyanto', 'F', '2005-09-06', 'Jln. Mandala 3', 'jessica.liyanto@mail.com', '081278654386'),
('C032', 'Selena P', 'F', '1975-11-20', 'Jln. Mawar 2', 'lena@mail.com', '085792401358'),
('C033', 'Kevin Harianto', 'M', '1992-04-12', 'Jln. Melati 18', 'kevin.h29@mail.com', '081355217788');

INSERT INTO MsObat VALUES
('AC001', 'Acnes', 25000),
('AD022', 'Amlodipine', 8000),
('AM013', 'Asam Mefenamat', 5500),
('AV039', 'Atorvastatin', 15000),
('BR060', 'Breathy', 43260),
('CR022', 'CDR (Calcium D Redoxon)', 53000),
('EC005', 'Ester C', 47300),
('FR028', 'Forumen', 38000),
('HV097', 'Hemaviton', 22500),
('IN010', 'Insto', 16000),
('LS092', 'Listerin', 33300),
('MZ033', 'Miconazole', 8950),
('PA055', 'Paracetamol', 6000),
('PR015', 'Procold', 6000),
('TM079', 'Tempra', 75000);


INSERT INTO MsDokter VALUES
('D001', 'SES-814', 'Dr. Rina K.', 'Umum'),
('D002', 'MEU-229', 'Dr. Tono W.', 'Anak'),
('D003', 'BKA-503', 'Dr. Santi D.', 'Gigi'),
('D004', 'PEH-667', 'Dr. Mira S.', 'Kulit'),
('D005', 'ASM-940', 'Dr. Agung B.', 'Jantung'),
('D006', 'MIS-374', 'Dr. Heru S.', 'THT'),
('D007', 'CIH-158', 'Dr. Lia P.', 'Mata'),
('D008', 'HRK-254', 'Dr. Vito B.', 'Tulang');

INSERT INTO TransactionHeader VALUES
('T001', 'D001', 'C001', 'A001', 'RS001A', '2025-09-01', 'Konsultasi & Obat', '09:00', '09:20', 80000, 'QRIS', 'Lunas'),
('T003', 'D003', 'C003', 'A003', 'RS002A', '2025-09-02', 'Konsultasi & Obat', '11:00', '11:25', 120000, 'Kartu Kredit', 'Lunas'),
('T005', 'D005', 'C005', 'A002', 'RS003A', '2025-09-03', 'Konsultasi & Obat', '08:30', '09:00', 120000, 'QRIS', 'Lunas'),
('T007', 'D006', 'C007', 'A003', 'RS007A', '2025-09-04', 'Konsultasi & Obat', '10:45', '10:57', 80000, 'E-Wallet', 'Lunas'),
('T008', 'D002', 'C008', 'A002', 'RS008A', '2025-09-04', 'Konsultasi & Obat', '15:00', '15:20', 80000, 'Transfer Bank', 'Lunas'),
('T009', 'D007', 'C009', 'A003', 'RS009A', '2025-09-05', 'Konsultasi & Obat', '09:30', '09:47', 80000, 'QRIS', 'Lunas'),
('T010', 'D005', 'C010', 'A001', 'RS010A', '2025-09-05', 'Konsultasi & Obat', '13:45', '14:13', 120000, 'Kartu Kredit', 'Lunas'),
('T011', 'D001', 'C011', 'A002', 'RS011A', '2025-09-06', 'Konsultasi & Obat', '17:00', '17:15', 80000, 'E-Wallet', 'Lunas'),
('T012', 'D004', 'C012', 'A003', 'RS012A', '2025-09-06', 'Konsultasi & Obat', '10:10', '10:30', 80000, 'E-Wallet', 'Lunas'),
('T013', 'D003', 'C013', 'A001', 'RS013A', '2025-09-07', 'Konsultasi & Obat', '12:00', '12:10', 40000, 'Transfer Bank', 'Lunas'),
('T014', 'D001', 'C014', 'A002', 'RS014A', '2025-09-07', 'Konsultasi & Obat', '14:40', '15:02', 120000, 'QRIS', 'Lunas'),
('T015', 'D005', 'C015', 'A001', 'RS015A', '2025-09-08', 'Konsultasi & Obat', '11:30', '11:55', 120000, 'E-Wallet', 'Lunas'),
('T016', 'D006', 'C016', 'A002', 'RS016A', '2025-09-08', 'Konsultasi & Obat', '16:30', '16:45', 80000, 'Kartu Kredit', 'Lunas'),
('T017', 'D001', 'C017', 'A002', 'RS017A', '2025-09-09', 'Konsultasi & Obat', '09:15', '09:32', 80000, 'QRIS', 'Lunas'),
('T018', 'D002', 'C018', 'A003', 'RS018A', '2025-09-09', 'Konsultasi & Obat', '14:00', '14:18', 80000, 'Transfer Bank', 'Lunas'),
('T019', 'D003', 'C019', 'A001', 'RS019A', '2025-09-10', 'Konsultasi & Obat', '11:45', '12:05', 80000, 'E-Wallet', 'Lunas'),
('T020', 'D004', 'C020', 'A001', 'RS020A', '2025-09-10', 'Konsultasi & Obat', '19:15', '19:30', 80000, 'QRIS', 'Lunas'),
('T021', 'D005', 'C021', 'A003', 'RS021A', '2025-09-11', 'Konsultasi & Obat', '08:45', '09:15', 120000, 'QRIS', 'Lunas'),
('T022', 'D001', 'C022', 'A003', 'RS022A', '2025-09-11', 'Konsultasi & Obat', '16:00', '16:20', 80000, 'E-Wallet', 'Lunas'),
('T023', 'D006', 'C023', 'A003', 'RS023A', '2025-09-12', 'Konsultasi & Obat', '10:30', '10:45', 80000, 'Kartu Kredit', 'Lunas'),
('T024', 'D002', 'C024', 'A001', 'RS024A', '2025-09-12', 'Konsultasi & Obat', '15:30', '15:55', 120000, 'Transfer Bank', 'Lunas'),
('T025', 'D007', 'C025', 'A001', 'RS025A', '2025-09-13', 'Konsultasi & Obat', '09:45', '09:55', 40000, 'QRIS', 'Lunas'),
('T026', 'D005', 'C026', 'A002', 'RS026A', '2025-09-13', 'Konsultasi & Obat', '13:30', '13:57', 120000, 'E-Wallet', 'Lunas'),
('T027', 'D001', 'C027', 'A002', 'RS027A', '2025-09-14', 'Konsultasi & Obat', '17:30', '17:46', 80000, 'E-Wallet', 'Lunas'),
('T028', 'D004', 'C028', 'A003', 'RS028A', '2025-09-14', 'Konsultasi & Obat', '10:00', '10:20', 80000, 'Transfer Bank', 'Lunas'),
('T029', 'D003', 'C029', 'A002', 'RS029A', '2025-09-15', 'Konsultasi & Obat', '12:30', '12:40', 40000, 'E-Wallet', 'Lunas'),
('T030', 'D001', 'C030', 'A002', 'RS030A', '2025-09-15', 'Konsultasi & Obat', '15:00', '15:20', 80000, 'QRIS', 'Lunas'),
('T031', 'D001', 'C025', 'A001', 'RS031A', '2025-09-15', 'Konsultasi & Obat', '17:30', '17:40', 40000, 'QRIS', 'Lunas'),
('T032', 'D003', 'C031', 'A003', 'RS032A', '2025-09-16', 'Konsultasi & Obat', '16:25', '16:40', 80000, 'QRIS', 'Lunas'),
('T033', 'D001', 'C032', 'A002', 'RS033A', '2025-09-17', 'Konsultasi & Obat', '15:15', '15:45', 120000, 'Transfer Bank', 'Lunas'),
('T034', 'D008', 'C033', 'A002', 'RS034A', '2025-09-17', 'Konsultasi & Obat', '16:15', '16:45', 120000, 'Transfer Bank', 'Lunas');

INSERT INTO PrescriptionDetail VALUES
('T001', 'PA055', '500 mg'),
('T003', 'AM013', '500 mg'),
('T005', 'AD022', '10 mg'),
('T007', 'FR028', '10 ml'),
('T008', 'TM079', '60 ml'),
('T009', 'IN010', '7,5 ml'),
('T010', 'AV039', '20 mg'),
('T011', 'PR015', '2 strip'),
('T012', 'MZ033', '10 gram'),
('T013', 'LS092', '80 ml'),
('T014', 'EC005', '500 mg'),
('T015', 'HV097', '1 strip'),
('T016', 'BR060', '60 ml'),
('T017', 'PA055', '500 mg'),
('T018', 'EC005', '500 mg'),
('T019', 'AM013', '500 mg'),
('T020', 'AC001', '12 gram'),
('T021', 'AD022', '5 mg'),
('T022', 'PR015', '1 strip'),
('T023', 'BR060', '60 ml'),
('T024', 'TM079', '60 ml'),
('T025', 'IN010', '7,5 ml'),
('T026', 'PR015', '10 mg'),
('T027', 'AV039', '1 strip'),
('T028', 'PR015', '10 gram'),
('T029', 'MZ033', '80 ml'),
('T030', 'LS092', '500 mg'),
('T031', 'EC005', '1 strip'),
('T032', 'LS092', '80 ml'),
('T033', 'PA055', '500 mg'),
('T034', 'CR022', '10 tablet');

