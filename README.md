# [ชื่อโปรเจกต์ / Project Name]

> Template สำหรับเริ่มโปรเจกต์ใหม่ — กด **Use this template** บน GitHub เพื่อสร้าง repository ของโปรเจกต์คุณ
> A reusable project template — click **Use this template** on GitHub to start a new project.

## ภาพรวมโปรเจกต์ (Project overview)

| หัวข้อ | รายละเอียด |
|---|---|
| **ชื่อโปรเจกต์** | [ใส่ชื่อโปรเจกต์] |
| **ปัญหา / วัตถุประสงค์** | [อธิบายปัญหาที่ต้องการแก้] |
| **สมาชิกทีม** | [ชื่อ – หน้าที่] |
| **อาจารย์ที่ปรึกษา** | [ชื่อ] |
| **สถานะ** | 🟡 วางแผน (Planning) |
| **อัปเดตล่าสุด** | [YYYY-MM-DD] |

## เริ่มต้นใช้งาน (Getting started)

1. กด **Use this template → Create a new repository** บน GitHub
2. แก้ชื่อโปรเจกต์และตารางภาพรวมด้านบน
3. อ่าน `README.md` ในแต่ละโฟลเดอร์ แล้วใส่ข้อมูลของโปรเจกต์ตัวเอง (โฟลเดอร์ไหนไม่ใช้ ลบได้)
4. ใช้แท็บ **Issues** สร้างงานย่อย และใช้ **Projects** ติดตามความคืบหน้า
5. เลือก License ก่อนเผยแพร่ผลงาน (ดู `LICENSE`)

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
