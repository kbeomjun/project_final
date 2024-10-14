drop database if exists fitness;
create database fitness;
use fitness;

drop table if exists `member`;
CREATE TABLE `member` (
   `me_id`   			varchar(100) 	primary key,
   `me_pw`   			varchar(100)   	NULL,
   `me_email`   		varchar(255)   	not NULL unique,
   `me_name`   			varchar(100)   	NULL,
   `me_phone`   		varchar(100)   	NULL,
   `me_postcode`		varchar(255)	NULL,
   `me_address`			varchar(255)	NULL,
   `me_detailAddress`	varchar(255)	NULL,
   `me_extraAddress`	varchar(255)	NULL,
   `me_birth`   		date   			not NULL,
   `me_gender`   		char(2)   		NULL,
   `me_authority`   	varchar(10)   	not NULL default 'USER',
   `me_cookie`   		varchar(255)   	NULL,
   `me_limit`   		datetime   		NULL,
   `me_noshow`   		int   			not null default 0,
   `me_cancel`   		datetime   		NULL
);

drop table if exists `branch`;
CREATE TABLE `branch` (
	`br_name`			varchar(100) 	primary key,
	`br_phone`			varchar(255)	not NULL,
	`br_postcode`		varchar(255)	not NULL,
    `br_address`		varchar(255)	not NULL,
    `br_detailAddress`	varchar(255)	not NULL,
    `br_extraAddress`	varchar(255)	not NULL,
	`br_detail`			longtext		NULL
);

drop table if exists `employee`;
CREATE TABLE `employee` (
	`em_num`			int 			primary key auto_increment,
	`em_name`			varchar(100)	not NULL,
	`em_phone`			varchar(255)	not NULL,
	`em_email`			varchar(255)	not NULL,
	`em_gender`			char(2)			not NULL,
	`em_position`		varchar(100)	not NULL,
	`em_join`			datetime		not NULL default current_timestamp,
    `em_postcode`		varchar(255)	not NULL,
    `em_address`		varchar(255)	not NULL,
    `em_detailAddress`	varchar(255)	not NULL,
    `em_extraAddress`	varchar(255)	not NULL,
	`em_fi_name`		varchar(255)	NULL,
	`em_br_name`		varchar(100)	NOT NULL
);

drop table if exists `branch_file`;
CREATE TABLE `branch_file` (
	`bf_num`		int 			primary key auto_increment,
	`bf_name`		varchar(255)	NULL,
	`bf_br_name`	varchar(100)	NOT NULL
);

drop table if exists `sports_equipment`;
CREATE TABLE `sports_equipment` (
	`se_name`		varchar(100) 	primary key,
	`se_fi_name`	varchar(255)	not NULL
);

drop table if exists `branch_equipment_stock`;
CREATE TABLE `branch_equipment_stock` (
	`be_num`		int 			primary key auto_increment,
	`be_amount`		int				not NULL,
	`be_birth`		date			not NULL,
	`be_record`		datetime		not NULL default current_timestamp,
	`be_type`		char(2)			not NULL,
	`be_br_name`	varchar(100)	NOT NULL,
	`be_se_name`	varchar(100)	NOT NULL
);

drop table if exists `sports_program`;
CREATE TABLE `sports_program` (
	`sp_name`		varchar(100) 	primary key,
	`sp_detail`		longtext		NULL,
    `sp_type`		char(2)			not NULL # '그룹', '단일'
);

drop table if exists `branch_program`;
CREATE TABLE `branch_program` (
	`bp_num`		int 			primary key auto_increment,
	`bp_total`		int				not NULL,
	`bp_br_name`	varchar(100)	NOT NULL,
	`bp_sp_name`	varchar(100)	NOT NULL,
	`bp_em_num`		int				NOT NULL
);

drop table if exists `review_post`;
CREATE TABLE `review_post` (
	`rp_num`		int 			primary key auto_increment	NOT NULL,
	`rp_title`		varchar(255)	not NULL,
	`rp_content`	longtext		not NULL,
    `rp_date`		datetime		not NULL default current_timestamp,
	`rp_view`		int				not NULL default 0,
    `rp_br_name`	varchar(100)	NOT NULL,
	`rp_pa_num`		int				NOT NULL
    
);

drop table if exists `member_inquiry`;
CREATE TABLE `member_inquiry` (
	`mi_num`		int 			primary key auto_increment,
	`mi_title`		varchar(255)	not NULL,
	`mi_content`	longtext		not NULL,
    `mi_answer`		longtext		null,
	`mi_state`		varchar(100)	not NULL default '답변대기중',
	`mi_email`		varchar(100)	not NULL,
    `mi_date`		datetime		not NULL default current_timestamp,
	`mi_br_name`	varchar(100)	NOT NULL,
	`mi_it_name`	varchar(100)	NOT NULL
);

drop table if exists `branch_order`;
CREATE TABLE `branch_order` (
	`bo_num`		int 			primary key auto_increment,
	`bo_amount`		int				not NULL,
	`bo_state`		varchar(100)	not NULL default '승인대기',
	`bo_date`		datetime		not NULL default current_timestamp,
	`bo_br_name`	varchar(100)	NOT NULL,
	`bo_se_name`	varchar(100)	not NULL
);

drop table if exists `program_reservation`;
CREATE TABLE `program_reservation` (
	`pr_num`		int 			primary key auto_increment,
	`pr_date`		datetime		not null default current_timestamp,
	`pr_me_id`		varchar(100)	NOT NULL,
	`pr_bs_num`		int				NULL
);

drop table if exists `inquiry_type`;
CREATE TABLE `inquiry_type` (
	`it_name`		varchar(100) 	primary key
);

drop table if exists `payment`;
CREATE TABLE `payment` (
	`pa_num`		int 			primary key auto_increment,
	`pa_date`		datetime		not NULL default current_timestamp,
	`pa_price`		int				not NULL,
	`pa_start`		datetime		not NULL,
	`pa_end`		datetime		not NULL,
	`pa_review`		char(1)			not NULL default 'N',
    `pa_state`		varchar(10)		not NULL,
	`pa_me_id`		varchar(100)	NULL,
	`pa_pt_num`		int				NOT NULL
);

drop table if exists `payment_type`;
CREATE TABLE `payment_type` (
	`pt_num`		int 			primary key auto_increment,
	`pt_type`		varchar(100)	not NULL,
	`pt_date`		int				not NULL,
    `pt_count`		int				not NULL,
	`pt_price`		int				not NULL
);
DROP TABLE IF EXISTS `payment_category`;

CREATE TABLE `payment_category` (
	`pc_num`			int 			primary key auto_increment NOT NULL,
	`pc_imp_uid`		varchar(30)		NOT NULL,
	`pc_merchant_uid`	varchar(50)		NOT NULL,
	`pc_amount`			int				NOT NULL,
	`pc_status`			varchar(10)		NOT NULL,
	`pc_paid_at`		bigint			NOT NULL,
	`pc_card_name`		varchar(30)		NULL,
	`pc_card_number`	bigint			NOT NULL,
	`pc_card_quota`		varchar(5)		NOT NULL,
	`pc_pt_num`			int				NOT NULL,
	`pc_me_id`			varchar(100)	NOT NULL
);


drop table if exists `branch_program_schedule`;
CREATE TABLE `branch_program_schedule` (
	`bs_num`		int 			primary key auto_increment,
	`bs_start`		datetime		not NULL,
	`bs_end`		datetime		not NULL,
	`bs_current`	int				not NULL default 0,
	`bs_bp_num`		int				NOT NULL
);

drop table if exists `refund`;
CREATE TABLE `refund` (
	`re_num`		int 		primary key auto_increment,
	`re_date`		datetime	not NULL default current_timestamp,
	`re_percent`	int			not NULL,
	`re_price`		int			not NULL,
	`re_reason`		longtext	NULL,
	`re_pa_num`		int			NOT NULL
);

drop table if exists `program_file`;
CREATE TABLE `program_file` (
   `pf_num`			int				primary key auto_increment,
   `pf_name`   		varchar(255)   	not NULL unique,
   `pf_sp_name`		varchar(100)   	not NULL
);

ALTER TABLE `program_file` 
ADD CONSTRAINT `FK_program_file_sports_program`
  FOREIGN KEY (`pf_sp_name`)
  REFERENCES `sports_program` (`sp_name`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `employee` 
ADD CONSTRAINT `FK_employee_branch`
  FOREIGN KEY (`em_br_name`)
  REFERENCES `branch` (`br_name`);

ALTER TABLE `branch_file` 
ADD CONSTRAINT `FK_branch_file_branch`
  FOREIGN KEY (`bf_br_name`)
  REFERENCES `branch` (`br_name`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `branch_equipment_stock` 
ADD CONSTRAINT `FK_equipment_stock_branch`
  FOREIGN KEY (`be_br_name`)
  REFERENCES `branch` (`br_name`)
  ON UPDATE CASCADE;

ALTER TABLE `branch_equipment_stock` 
ADD CONSTRAINT `FK_equipment_stock_sport`
  FOREIGN KEY (`be_se_name`)
  REFERENCES `sports_equipment` (`se_name`)
  ON UPDATE CASCADE;

ALTER TABLE `branch_program` 
ADD CONSTRAINT `FK_branch_program_branch`
  FOREIGN KEY (`bp_br_name`)
  REFERENCES `branch` (`br_name`)
  ON UPDATE CASCADE;

ALTER TABLE `branch_program` 
ADD CONSTRAINT `FK_branch_program_sport`
  FOREIGN KEY (`bp_sp_name`)
  REFERENCES `sports_program` (`sp_name`)
  ON DELETE CASCADE
  ON UPDATE RESTRICT;

ALTER TABLE `branch_program` 
ADD CONSTRAINT `FK_branch_program_employee`
  FOREIGN KEY (`bp_em_num`)
  REFERENCES `employee` (`em_num`)
  ON DELETE CASCADE;

ALTER TABLE `branch_program_schedule` 
ADD CONSTRAINT `FK_program_schedule_branch_program`
  FOREIGN KEY (`bs_bp_num`)
  REFERENCES `branch_program` (`bp_num`)
  ON DELETE CASCADE;

ALTER TABLE `program_reservation` 
ADD CONSTRAINT `FK_program_reservation_schedule`
  FOREIGN KEY (`pr_bs_num`)
  REFERENCES `branch_program_schedule` (`bs_num`)
  ON DELETE SET NULL;

ALTER TABLE `payment` 
ADD CONSTRAINT `FK_payment_member`
  FOREIGN KEY (`pa_me_id`)
  REFERENCES `member` (`me_id`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;


ALTER TABLE `review_post` 
ADD CONSTRAINT `FK_review_post_branch`
  FOREIGN KEY (`rp_br_name`)
  REFERENCES `branch` (`br_name`)
  ON UPDATE CASCADE;

ALTER TABLE `member_inquiry` 
ADD CONSTRAINT `FK_member_inquiry_branch`
  FOREIGN KEY (`mi_br_name`)
  REFERENCES `branch` (`br_name`)
  ON UPDATE CASCADE;

ALTER TABLE `member_inquiry` 
ADD CONSTRAINT `FK_member_inquiry_type`
  FOREIGN KEY (`mi_it_name`)
  REFERENCES `inquiry_type` (`it_name`)
  ON UPDATE CASCADE;

ALTER TABLE `branch_order` 
ADD CONSTRAINT `FK_branch_order_branch`
  FOREIGN KEY (`bo_br_name`)
  REFERENCES `branch` (`br_name`)
  ON UPDATE CASCADE;