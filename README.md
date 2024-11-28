# Hướng dẫn khởi chạy Jenkins trên EC2 và cấu hình Pipeline

1. Khởi động EC2 Instance.
2. Cài đặt Jenkins trên Instance.
3. Truy cập vào Jenkins Dashboard.
4. Chọn **New Item**.
5. Chọn **Pipeline**.
6. Tick vào **GitHub hook trigger for GITScm polling**.
7. Chọn **Pipeline script from SCM**.
8. Chọn **Git** và nhập repository.
9. Chọn Secret Token cho GitHub và nhấn **Apply**.
10. Cập nhật thay đổi trên nhánh master để chạy Pipeline.
