# **📚 N8N Book Translator \- Local AI Edition**

**Giải pháp dịch thuật sách tự động, bảo mật và miễn phí ngay trên máy tính cá nhân.**

## **📖 Giới thiệu**

**N8N Book Translator** là bộ công cụ tự động hóa (Workflow) giúp bạn chuyển ngữ toàn bộ cuốn sách (Ebook, Text, Docx) sang tiếng Việt (hoặc ngôn ngữ khác) bằng cách sử dụng sức mạnh của AI chạy cục bộ (Local LLM) thông qua Ollama.

Dự án được thiết kế với tiêu chí **"Riêng tư \- Miễn phí \- Dễ sử dụng"**, loại bỏ hoàn toàn sự phụ thuộc vào các API đắt đỏ hay lo ngại về rò rỉ dữ liệu sách.

### **✨ Tính năng nổi bật**

* **100% Offline & Bảo mật:** Dữ liệu sách được xử lý cục bộ, không bao giờ gửi ra ngoài máy tính của bạn.  
* **Chi phí bằng 0:** Sử dụng mô hình AI mã nguồn mở (như Qwen, Llama, Gemma).  
* **Dịch theo ngữ cảnh:** Cơ chế cắt đoạn thông minh, giữ nguyên ngữ cảnh và văn phong của tác phẩm.  
* **Thiết kế linh hoạt (Portable):** Tự động nhận diện môi trường, ghi nhớ thư mục làm việc, "cắm là chạy".  
* **Tự động tạo từ điển:** Tự động trích xuất và xây dựng danh sách tên riêng (Nhân vật, Địa danh) để đảm bảo tính nhất quán khi dịch truyện dài.

## **🛠️ Yêu cầu hệ thống**

Để công cụ hoạt động ổn định, máy tính cần đáp ứng cấu hình tối thiểu:

* **Hệ điều hành:** Windows 10 hoặc 11 (64-bit).  
* **RAM:** Tối thiểu 16GB (Khuyến nghị 32GB nếu dùng model 14B).  
* **GPU:** Khuyến nghị có NVIDIA GPU (VRAM 8GB+) để tối ưu tốc độ dịch.  
* **Ổ cứng:** Trống khoảng 20GB (để chứa Model AI).

## **📦 Cấu trúc dự án**

Bộ công cụ bao gồm các file sau:

N8N-Book-Translator/  
│  
├── 🟢 Setup\_n8n\_book\_translator.bat         \# Chạy lần đầu: Cài đặt môi trường (Node.js, n8n, Ollama...)  
├── 🟡 Start\_n8n\_book\_translator.bat         \# Chạy hàng ngày: Khởi động Tool và AI (Launcher)  
├── 🔴 Reset\_setting\_n8n\_book\_translator.bat \# Tiện ích: Xóa cấu hình thư mục cũ  
├── 📄 Book translator portable.json         \# Core: File quy trình n8n (Import vào tool)  
└── 📖 README.md                             \# Tài liệu hướng dẫn

## **🚀 Hướng dẫn cài đặt (Lần đầu tiên)**

Bạn chỉ cần thực hiện bước này một lần duy nhất khi mới tải về.

1. **Tải dự án:** Clone repository hoặc tải file ZIP về máy và giải nén.  
2. **Chạy file Setup:**  
   * Chạy file Setup\_n8n\_book\_translator.bat.  
   * Cửa sổ cài đặt sẽ hiện ra. Script sẽ tự động kiểm tra máy bạn thiếu thành phần nào (Node.js, Pandoc, Ollama) và hỏi bạn có muốn cài đặt không.  
   * *Nhập y (Yes) và nhấn Enter để đồng ý cài đặt.*  
3. **Chờ đợi:** Script sẽ tự động tải Model AI (mặc định là qwen3:14b). Vui lòng không tắt mạng.

## **🎮 Hướng dẫn sử dụng**

### **Bước 1: Khởi động hệ thống**

Chạy file Start\_n8n\_book\_translator.bat.

* **Thiết lập thư mục:** Trong lần chạy đầu tiên, tool sẽ yêu cầu bạn chọn:  
  1. **Thư mục đầu vào (Input):** Nơi chứa file sách gốc cần dịch.  
  2. Thư mục đầu ra (Output): Nơi lưu file kết quả.  
     Tool sẽ tự động ghi nhớ cài đặt này vào file settings.ini cho các lần sau.

**⚠️ QUAN TRỌNG:** Một cửa sổ dòng lệnh (Terminal) màu đen sẽ xuất hiện và giữ nguyên trạng thái mở. Đây là máy chủ cục bộ giúp tool hoạt động. **Vui lòng KHÔNG tắt cửa sổ này** (chỉ thu nhỏ xuống Taskbar).

### **Bước 2: Import Workflow (Chỉ làm lần đầu)**

1. Trình duyệt sẽ tự động mở trang http://localhost:5678.  
2. Nếu n8n yêu cầu, hãy tạo một tài khoản (dữ liệu chỉ lưu trên máy bạn).  
3. Tại giao diện chính, chọn menu **Workflows** ➝ **Import Workflow**.  
4. Chọn file Book translator portable.json trong thư mục dự án.

### **Bước 3: Bắt đầu dịch**

1. Trong n8n, bật công tắc **Active** (góc trên bên phải) sang màu xanh lá.  
2. Copy file sách của bạn (.txt, .epub hoặc .docx) vào thư mục **Input** mà bạn đã chọn.  
3. Tool sẽ tự động phát hiện file mới và bắt đầu quy trình dịch.  
4. Kết quả sẽ xuất hiện trong thư mục **Output** với tên file có đuôi \_translated.txt.

## **⚙️ Quản lý & Tinh chỉnh**

### **1\. Thay đổi thư mục làm việc**

Nếu bạn muốn đổi folder Input/Output sang vị trí khác:

* Chạy file Reset\_setting\_n8n\_book\_translator.bat.  
* Lần tới khi chạy file start..., tool sẽ hỏi lại vị trí thư mục mới.

### **2\. Thay đổi Model AI**

Mặc định tool sử dụng qwen3:14b. Nếu máy yếu hoặc muốn dùng model khác (VD: gemma2:9b):

1. Mở CMD và chạy lệnh tải model: ollama pull gemma2:9b.  
2. Vào n8n, mở Workflow, tìm các node **HTTP Request**.  
3. Sửa tên model trong phần JSON Body (của cả 3 node AI) thành gemma2:9b.

## **❓ Xử lý lỗi thường gặp**

| Vấn đề | Nguyên nhân & Cách khắc phục |
| :---- | :---- |
| **Báo lỗi undefined tại Node Trigger** | Đây là bình thường khi bạn xem workflow ở chế độ chỉnh sửa mà chưa chạy file .bat. Hãy tắt n8n và chạy file Start\_n8n\_book\_translator.bat để nạp biến môi trường. |
| **Không thấy file kết quả** | 1\. Kiểm tra xem bạn đã bật nút **Active** chưa. 2\. Kiểm tra cửa sổ Terminal đen có bị tắt nhầm không. |
| **Lỗi đọc file Word/Epub** | Máy bạn chưa cài Pandoc. Hãy chạy lại file setup...bat và chọn y để cài Pandoc. |

## **👨‍💻 Tác giả & Bản quyền**

Dự án được phát triển bởi **d-init-d**.

Mọi đóng góp, báo lỗi hoặc ý tưởng cải tiến đều được hoan nghênh. Nếu thấy dự án hữu ích, hãy tặng cho mình một ⭐️ trên GitHub nhé\!

*Phát triển và kiểm thử trên **Dell Precision 5570 **(32GB RAM • RTX A2000 8GB).*
