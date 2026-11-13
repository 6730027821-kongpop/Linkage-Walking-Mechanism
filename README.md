# Linkage Walking Mechanism

กลไกเดินแบบ linkage (ขาเดียว) — วิเคราะห์จลนศาสตร์ด้วย MATLAB Symbolic Math และสร้างชิ้นงานจริง

🎥 **วิดีโอสาธิต:** [YouTube Shorts](https://youtube.com/shorts/H6VvG0fA-Pw)

## ภาพรวมโปรเจกต์ (Project overview)

| หัวข้อ | รายละเอียด |
|---|---|
| **ชื่อโปรเจกต์** | Linkage Walking Mechanism |
| **ปัญหา / วัตถุประสงค์** | [อธิบายปัญหาที่ต้องการแก้] |
| **สมาชิกทีม** | [ชื่อ – หน้าที่] |
| **อาจารย์ที่ปรึกษา** | [ชื่อ] |
| **สถานะ** | 🟡 วางแผน (Planning) |
| **อัปเดตล่าสุด** | 2026-11-13 |

## โครงสร้าง (Repository structure)

| โฟลเดอร์ | ใช้เก็บอะไร |
|---|---|
| `hardware/mechanical/` | ไฟล์ CAD, แบบ drawing, ไฟล์สำหรับผลิต (STL, DXF) |
| `hardware/electronics/` | วงจร (schematic), PCB, แผนผังการต่อสาย |
| `hardware/bom.csv` | รายการวัสดุ/ชิ้นส่วน (Bill of Materials) พร้อมราคาและแหล่งซื้อ |
| `software/firmware/` | โค้ดไมโครคอนโทรลเลอร์ (Arduino, ESP32, STM32) |
| `software/application/` | โปรแกรมบน PC / Raspberry Pi / เว็บ |
| `machine-skills/` | ขั้นตอนการใช้เครื่องจักร, G-code, คำสั่งเครื่อง |
| `simulation/` | โมเดลจำลอง, สคริปต์, สมมติฐาน, ผลการจำลอง |
| `docs/` | คู่มือประกอบ ติดตั้ง ใช้งาน และบำรุงรักษา |
| `media/` | รูป, GIF, ลิงก์วิดีโอสาธิต |
| `experiments/` | ขั้นตอนการทดลอง, ข้อมูลดิบ, ผลลัพธ์ |
| `publications/` | รายงาน, บทความ, สไลด์นำเสนอ |

## แนวทางการทำงานร่วมกัน (Collaboration)

- ตั้งชื่อไฟล์ให้สื่อความหมาย เช่น `gear-housing_rev02.step` แทน `final_final2.step`
- เขียน commit message ให้ชัดเจน เช่น `Add motor mount v2 with M4 holes`
- ระบุหน่วย, เวอร์ชันซอฟต์แวร์, และสมมติฐานทุกครั้ง
- ห้าม commit รหัสผ่าน, API key หรือข้อมูลส่วนตัว
- ไฟล์ใหญ่ (CAD, วิดีโอ, ผลจำลอง) ควรใช้ [Git LFS](https://git-lfs.com/)

## ความปลอดภัยและการตรวจสอบ (Safety & validation)

บันทึกอันตราย มาตรการป้องกัน และขีดจำกัดการใช้งานก่อนทดสอบฮาร์ดแวร์จริง และตรวจสอบผลคำนวณ/ผลจำลองกับค่าที่วัดได้จริงเสมอเมื่อทำได้
