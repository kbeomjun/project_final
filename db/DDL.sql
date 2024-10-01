drop database if exists fitness;
create database fitness;
use fitness;

drop table if exists `member`;
CREATE TABLE `member` (
   `me_id`   		varchar(100) 	primary key,
   `me_pw`   		varchar(100)   	NULL,
   `me_email`   	varchar(255)   	not NULL unique,
   `me_name`   		varchar(100)   	NULL,
   `me_phone`   	varchar(100)   	NULL,
   `me_address`   	varchar(255)   	NULL,
   `me_birth`   	date   			not NULL,
   `me_gender`   	char(2)   		NULL,
   `me_authority`   varchar(10)   	not NULL default 'USER',
   `me_cookie`   	varchar(255)   	NULL,
   `me_limit`   	datetime   		NULL,
   `me_noshow`   	int   			not null default 0,
   `me_cancel`   	datetime   		NULL
);

drop table if exists `branch`;
CREATE TABLE `branch` (
	`br_name`		varchar(100) 	primary key,
	`br_phone`		varchar(255)	not NULL,
	`br_postcode`	varchar(255)	not NULL,
    `br_address`	varchar(255)	not NULL,
    `br_detailAddress`	varchar(255)	not NULL,
    `br_extraAddress`	varchar(255)	not NULL,
	`br_detail`		longtext		NULL
);

drop table if exists `employee`;
CREATE TABLE `employee` (
	`em_num`		int 			primary key auto_increment,
	`em_name`		varchar(100)	not NULL,
	`em_phone`		varchar(255)	not NULL,
	`em_email`		varchar(255)	not NULL,
	`em_gender`		char(2)			not NULL,
	`em_position`	varchar(100)	not NULL,
	`em_join`		datetime		not NULL default current_timestamp,
	`em_address`	varchar(255)	not NULL,
	`em_fi_name`	varchar(255)	NULL,
	`em_br_name`	varchar(100)	NOT NULL
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
	`rp_br_name`	varchar(100)	NOT NULL,
	`rp_pa_num`		int				NOT NULL
);

drop table if exists `member_inquiry`;
CREATE TABLE `member_inquiry` (
	`mi_num`		int 			primary key auto_increment,
	`mi_title`		varchar(255)	not NULL,
	`mi_content`	longtext		not NULL,
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
	`bo_state`		varchar(100)	not NULL,
	`bo_date`		datetime		not NULL default current_timestamp,
	`bo_br_name`	varchar(100)	NOT NULL,
	`bo_se_name`	varchar(100)	not NULL
);

drop table if exists `program_reservation`;
CREATE TABLE `program_reservation` (
	`pr_num`		int 			primary key auto_increment,
	`pr_date`		datetime		not null default current_timestamp,
	`pr_me_id`		varchar(100)	NOT NULL,
	`pr_bs_num`		int				NOT NULL
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
	`pa_me_id`		varchar(100)	NOT NULL,
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



ALTER TABLE `employee` ADD CONSTRAINT `FK_branch_TO_employee_1` FOREIGN KEY (
	`em_br_name`
)
REFERENCES `branch` (
	`br_name`
);

ALTER TABLE `branch_file` ADD CONSTRAINT `FK_branch_TO_branch_file_1` FOREIGN KEY (
	`bf_br_name`
)
REFERENCES `branch` (
	`br_name`
);

ALTER TABLE `branch_equipment_stock` ADD CONSTRAINT `FK_branch_TO_branch_equipment_stock_1` FOREIGN KEY (
	`be_br_name`
)
REFERENCES `branch` (
	`br_name`
);

ALTER TABLE `branch_equipment_stock` ADD CONSTRAINT `FK_sports_equipment_TO_branch_equipment_stock_1` FOREIGN KEY (
	`be_se_name`
)
REFERENCES `sports_equipment` (
	`se_name`
);

ALTER TABLE `branch_program` ADD CONSTRAINT `FK_branch_TO_branch_program_1` FOREIGN KEY (
	`bp_br_name`
)
REFERENCES `branch` (
	`br_name`
);

ALTER TABLE `branch_program` ADD CONSTRAINT `FK_sports_program_TO_branch_program_1` FOREIGN KEY (
	`bp_sp_name`
)
REFERENCES `sports_program` (
	`sp_name`
);

ALTER TABLE `branch_program` ADD CONSTRAINT `FK_employee_TO_branch_program_1` FOREIGN KEY (
	`bp_em_num`
)
REFERENCES `employee` (
	`em_num`
);

ALTER TABLE `review_post` ADD CONSTRAINT `FK_branch_TO_review_post_1` FOREIGN KEY (
	`rp_br_name`
)
REFERENCES `branch` (
	`br_name`
);

ALTER TABLE `review_post` ADD CONSTRAINT `FK_payment_TO_review_post_1` FOREIGN KEY (
	`rp_pa_num`
)
REFERENCES `payment` (
	`pa_num`
);

ALTER TABLE `member_inquiry` ADD CONSTRAINT `FK_branch_TO_member_inquiry_1` FOREIGN KEY (
	`mi_br_name`
)
REFERENCES `branch` (
	`br_name`
);

ALTER TABLE `member_inquiry` ADD CONSTRAINT `FK_inquiry_type_TO_member_inquiry_1` FOREIGN KEY (
	`mi_it_name`
)
REFERENCES `inquiry_type` (
	`it_name`
);

ALTER TABLE `branch_order` ADD CONSTRAINT `FK_branch_TO_branch_order_1` FOREIGN KEY (
	`bo_br_name`
)
REFERENCES `branch` (
	`br_name`
);

ALTER TABLE `program_reservation` ADD CONSTRAINT `FK_member_TO_program_reservation_1` FOREIGN KEY (
	`pr_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `program_reservation` ADD CONSTRAINT `FK_branch_program_schedule_TO_program_reservation_1` FOREIGN KEY (
	`pr_bs_num`
)
REFERENCES `branch_program_schedule` (
	`bs_num`
);

ALTER TABLE `payment` ADD CONSTRAINT `FK_member_TO_payment_1` FOREIGN KEY (
	`pa_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `payment` ADD CONSTRAINT `FK_payment_type_TO_payment_1` FOREIGN KEY (
	`pa_pt_num`
)
REFERENCES `payment_type` (
	`pt_num`
);

ALTER TABLE `branch_program_schedule` ADD CONSTRAINT `FK_branch_program_TO_branch_program_schedule_1` FOREIGN KEY (
	`bs_bp_num`
)
REFERENCES `branch_program` (
	`bp_num`
);

ALTER TABLE `refund` ADD CONSTRAINT `FK_payment_TO_refund_1` FOREIGN KEY (
	`re_pa_num`
)
REFERENCES `payment` (
	`pa_num`
);

ALTER TABLE `fitness`.`payment` 
DROP FOREIGN KEY `FK_member_TO_payment_1`;
ALTER TABLE `fitness`.`payment` 
CHANGE COLUMN `pa_me_id` `pa_me_id` VARCHAR(100) NULL ;
ALTER TABLE `fitness`.`payment` 
ADD CONSTRAINT `FK_member_TO_payment_1`
  FOREIGN KEY (`pa_me_id`)
  REFERENCES `fitness`.`member` (`me_id`)
  ON UPDATE RESTRICT;
  
ALTER TABLE `fitness`.`payment` 
DROP FOREIGN KEY `FK_member_TO_payment_1`;
ALTER TABLE `fitness`.`payment` 
ADD CONSTRAINT `FK_member_TO_payment_1`
  FOREIGN KEY (`pa_me_id`)
  REFERENCES `fitness`.`member` (`me_id`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
  ALTER TABLE `fitness`.`payment` 
DROP FOREIGN KEY `FK_member_TO_payment_1`;
ALTER TABLE `fitness`.`payment` 
ADD CONSTRAINT `FK_member_TO_payment_1`
  FOREIGN KEY (`pa_me_id`)
  REFERENCES `fitness`.`member` (`me_id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
  ALTER TABLE `fitness`.`review_post` 
DROP FOREIGN KEY `FK_branch_TO_review_post_1`;
ALTER TABLE `fitness`.`review_post` 
ADD CONSTRAINT `FK_branch_TO_review_post_1`
  FOREIGN KEY (`rp_br_name`)
  REFERENCES `fitness`.`branch` (`br_name`)
  ON UPDATE CASCADE;

ALTER TABLE `fitness`.`member_inquiry` 
DROP FOREIGN KEY `FK_branch_TO_member_inquiry_1`;
ALTER TABLE `fitness`.`member_inquiry` 
ADD CONSTRAINT `FK_branch_TO_member_inquiry_1`
  FOREIGN KEY (`mi_br_name`)
  REFERENCES `fitness`.`branch` (`br_name`)
  ON UPDATE CASCADE;
  
  ALTER TABLE `fitness`.`member_inquiry` 
DROP FOREIGN KEY `FK_inquiry_type_TO_member_inquiry_1`;
ALTER TABLE `fitness`.`member_inquiry` 
ADD CONSTRAINT `FK_inquiry_type_TO_member_inquiry_1`
  FOREIGN KEY (`mi_it_name`)
  REFERENCES `fitness`.`inquiry_type` (`it_name`)
  ON UPDATE CASCADE;
  
  ALTER TABLE `fitness`.`branch_program` 
DROP FOREIGN KEY `FK_sports_program_TO_branch_program_1`;
ALTER TABLE `fitness`.`branch_program` 
ADD CONSTRAINT `FK_sports_program_TO_branch_program_1`
  FOREIGN KEY (`bp_sp_name`)
  REFERENCES `fitness`.`sports_program` (`sp_name`)
  ON DELETE CASCADE
  ON UPDATE RESTRICT;
  
  ALTER TABLE `fitness`.`branch_program` 
DROP FOREIGN KEY `FK_employee_TO_branch_program_1`;
ALTER TABLE `fitness`.`branch_program` 
ADD CONSTRAINT `FK_employee_TO_branch_program_1`
  FOREIGN KEY (`bp_em_num`)
  REFERENCES `fitness`.`employee` (`em_num`)
  ON DELETE CASCADE;
  
  ALTER TABLE `fitness`.`branch_program` 
DROP FOREIGN KEY `FK_branch_TO_branch_program_1`;
ALTER TABLE `fitness`.`branch_program` 
ADD CONSTRAINT `FK_branch_TO_branch_program_1`
  FOREIGN KEY (`bp_br_name`)
  REFERENCES `fitness`.`branch` (`br_name`)
  ON UPDATE CASCADE;
  
  ALTER TABLE `fitness`.`branch_program_schedule` 
DROP FOREIGN KEY `FK_branch_program_TO_branch_program_schedule_1`;
ALTER TABLE `fitness`.`branch_program_schedule` 
ADD CONSTRAINT `FK_branch_program_TO_branch_program_schedule_1`
  FOREIGN KEY (`bs_bp_num`)
  REFERENCES `fitness`.`branch_program` (`bp_num`)
  ON DELETE CASCADE;
  
  ALTER TABLE `fitness`.`program_reservation` 
DROP FOREIGN KEY `FK_branch_program_schedule_TO_program_reservation_1`;
ALTER TABLE `fitness`.`program_reservation` 
CHANGE COLUMN `pr_bs_num` `pr_bs_num` INT NULL ;
ALTER TABLE `fitness`.`program_reservation` 
ADD CONSTRAINT `FK_branch_program_schedule_TO_program_reservation_1`
  FOREIGN KEY (`pr_bs_num`)
  REFERENCES `fitness`.`branch_program_schedule` (`bs_num`)
  ON DELETE RESTRICT;
  
  ALTER TABLE `fitness`.`program_reservation` 
DROP FOREIGN KEY `FK_branch_program_schedule_TO_program_reservation_1`;
ALTER TABLE `fitness`.`program_reservation` 
ADD CONSTRAINT `FK_branch_program_schedule_TO_program_reservation_1`
  FOREIGN KEY (`pr_bs_num`)
  REFERENCES `fitness`.`branch_program_schedule` (`bs_num`)
  ON DELETE SET NULL;
  
  ALTER TABLE `fitness`.`branch_file` 
DROP FOREIGN KEY `FK_branch_TO_branch_file_1`;
ALTER TABLE `fitness`.`branch_file` 
ADD CONSTRAINT `FK_branch_TO_branch_file_1`
  FOREIGN KEY (`bf_br_name`)
  REFERENCES `fitness`.`branch` (`br_name`)
  ON DELETE CASCADE;
  
  ALTER TABLE `fitness`.`branch_file` 
DROP FOREIGN KEY `FK_branch_TO_branch_file_1`;
ALTER TABLE `fitness`.`branch_file` 
ADD CONSTRAINT `FK_branch_TO_branch_file_1`
  FOREIGN KEY (`bf_br_name`)
  REFERENCES `fitness`.`branch` (`br_name`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
  ALTER TABLE `fitness`.`branch_order` 
DROP FOREIGN KEY `FK_branch_TO_branch_order_1`;
ALTER TABLE `fitness`.`branch_order` 
ADD CONSTRAINT `FK_branch_TO_branch_order_1`
  FOREIGN KEY (`bo_br_name`)
  REFERENCES `fitness`.`branch` (`br_name`)
  ON UPDATE CASCADE;
  
  ALTER TABLE `fitness`.`branch_equipment_stock` 
DROP FOREIGN KEY `FK_branch_TO_branch_equipment_stock_1`;
ALTER TABLE `fitness`.`branch_equipment_stock` 
ADD CONSTRAINT `FK_branch_TO_branch_equipment_stock_1`
  FOREIGN KEY (`be_br_name`)
  REFERENCES `fitness`.`branch` (`br_name`)
  ON UPDATE CASCADE;
  
  ALTER TABLE `fitness`.`branch_equipment_stock` 
DROP FOREIGN KEY `FK_sports_equipment_TO_branch_equipment_stock_1`;
ALTER TABLE `fitness`.`branch_equipment_stock` 
ADD CONSTRAINT `FK_sports_equipment_TO_branch_equipment_stock_1`
  FOREIGN KEY (`be_se_name`)
  REFERENCES `fitness`.`sports_equipment` (`se_name`)
  ON UPDATE CASCADE;