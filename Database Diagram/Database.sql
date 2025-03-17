CREATE TABLE `nguoi_dung` (
  `id` uuid PRIMARY KEY,
  `ho_ten` varchar(255),
  `ngay_sinh` date,
  `gioi_tinh` varchar(255),
  `so_dien_thoai` varchar(255),
  `que_quan` varchar(255),
  `email` varchar(255),
  `ngay_tao` timestamp,
  `ngay_cap_nhat` timestamp,
  `da_xoa` boolean
);

CREATE TABLE `giao_vien` (
  `id` varchar(255) PRIMARY KEY,
  `id_nguoi_dung` uuid,
  `bo_mon` varchar(255),
  `ngay_tao` timestamp,
  `ngay_cap_nhat` timestamp,
  `da_xoa` boolean
);

CREATE TABLE `sinh_vien` (
  `id` varchar(255) PRIMARY KEY,
  `id_nguoi_dung` uuid,
  `ma_he` ENUM ('elitech', 'chuan'),
  `trang_thai` ENUM ('dang_hoc', 'thoi_hoc', 'buoc_thoi_hoc', 'tot_nghiep'),
  `ngay_tao` timestamp,
  `ngay_cap_nhat` timestamp,
  `da_xoa` boolean
);


CREATE TABLE `mon_hoc` (
  `id` varchar(255) PRIMARY KEY,
  `ten_mon` varchar(255),
  `so_tin_chi` int,
  `id_mon_tien_quyet` uuid COMMENT 'nullable',
  `so_tin_hoc_phan` int,
  `so_tin_hoc_phi` int,
  `ngay_tao` timestamp,
  `ngay_cap_nhat` timestamp,
  `da_xoa` boolean
);

CREATE TABLE `hoc_ky` (
  `id` varchar(255) PRIMARY KEY,
  `ten_hoc_ky` varchar(255),
  `nam_hoc` varchar(255),
  `ngay_bat_dau` date,
  `ngay_ket_thuc` date,
  `ngay_tao` timestamp,
  `ngay_cap_nhat` timestamp,
  `da_xoa` boolean
);

CREATE TABLE `lop_hoc` (
  `id` varchar(255) PRIMARY KEY,
  `id_mon_hoc` varchar(255),
  `id_hoc_ky` varchar(255),
  `id_giao_vien` varchar(255),
  `so_sinh_vien_toi_da` int,
  `he_dao_tao` ENUM ('elitech', 'chuan'),
  `loai_lop` ENUM ('lop_thi_nghiem', 'lop_ly_thuyet'),
  `ngay_tao` timestamp,
  `ngay_cap_nhat` timestamp,
  `da_xoa` boolean
);

CREATE TABLE `dang_ky` (
  `id` uuid PRIMARY KEY,
  `id_lop_hoc` varchar(255),
  `id_sinh_vien` varchar(255) UNIQUE,
  `trang_thai` ENUM ('inserting', 'thanh_cong', 'that_bai'),
  `thoi_gian_dang_ky` timestamp,
  `ngay_tao` timestamp,
  `ngay_cap_nhat` timestamp,
  `da_xoa` boolean
);

CREATE TABLE `don_xin_mo_lop` (
  `id` uuid PRIMARY KEY,
  `id_sinh_vien` varchar(255),
  `id_mon_hoc` varchar(255),
  `nguyen_nhan` text,
  `trang_thai` ENUM ('approved', 'pending', 'rejected'),
  `ngay_tao` timestamp,
  `ngay_cap_nhat` timestamp,
  `da_xoa` boolean
);

ALTER TABLE `giao_vien` ADD FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`);

ALTER TABLE `sinh_vien` ADD FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`);

ALTER TABLE `mon_hoc` ADD FOREIGN KEY (`id_mon_tien_quyet`) REFERENCES `mon_hoc` (`id`);

ALTER TABLE `lop_hoc` ADD FOREIGN KEY (`id_mon_hoc`) REFERENCES `mon_hoc` (`id`);

ALTER TABLE `lop_hoc` ADD FOREIGN KEY (`id_hoc_ky`) REFERENCES `hoc_ky` (`id`);

ALTER TABLE `lop_hoc` ADD FOREIGN KEY (`id_giao_vien`) REFERENCES `giao_vien` (`id`);

ALTER TABLE `dang_ky` ADD FOREIGN KEY (`id_lop_hoc`) REFERENCES `lop_hoc` (`id`);

ALTER TABLE `dang_ky` ADD FOREIGN KEY (`id_sinh_vien`) REFERENCES `sinh_vien` (`id`);

ALTER TABLE `don_xin_mo_lop` ADD FOREIGN KEY (`id_sinh_vien`) REFERENCES `sinh_vien` (`id`);

ALTER TABLE `don_xin_mo_lop` ADD FOREIGN KEY (`id_mon_hoc`) REFERENCES `mon_hoc` (`id`);
