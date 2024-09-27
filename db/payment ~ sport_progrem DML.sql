#PT 이용권 추가
delete from `payment_type`;
insert into `payment_type` (pt_type, pt_date, pt_count, pt_price)
	values
		('10회', 30, 10, 600000),
        ('20회', 60, 20, 1200000),
        ('30회', 90, 30, 1800000);

# 결제 내역 추가
delete from `payment`;
insert into `payment` (pa_price, pa_start, pa_end, pa_state, pa_me_id, pa_pt_num)
	values
		(300000, '2024-09-27', '2024-10-27', '결제완료', 'user1', '1'),
        (900000, '2024-09-27', '2024-12-27', '결제완료', 'user2', '2'),
        (1200000, '2024-09-27', '2025-03-27', '결제완료', 'user3', '3');

# 헬스장 이용권 추가
delete from `payment_type`;
insert into `payment_type` (pt_type, pt_date, pt_count, pt_price) 
	values
		('1개월 이용권', 30, 1, 300000),
		('3개월 이용권', 90, 1, 900000),
        ('6개월 이용권', 180, 1, 1200000);

#프로그램 예약 추가
delete from `program_reservation`;
insert into `program_reservation` (pr_me_id, pr_bs_num)
	values
		('user1', 1),
        ('user2', 2),
        ('user3', 3);
	
#환불 내역 추가
delete from `refund`;
insert into `refund` (re_percent, re_price, re_reason, re_pa_num)
	values
		('50', '150000', '중도 해지', 1),
        ('100', '300000', '시작 전 계약 취소', 2),
        ('75', '225000', '중도 해지', 3);
        
#리뷰 게시글 추가
delete from `review_post`;
insert into `review_post` (rp_title, rp_content, rp_br_name, rp_pa_num)
	values
		('서비스가 좋았습니다', '최고예요', '역삼점', '1'),
        ('서비스가 그냥 그랬습니다', '다닐만은 해요', '강남점', '2'),
        ('서비스가 별오 안좋았습니다', '비추천합니다', '신논현점', '3');
        
#운동 기구명 추가
delete from `sports_equipment`;
insert into `sports_equipment` (se_name, se_fi_name)
	values
		('런닝머신', 'gyms-and-health-clubs_01s'),
        ('스피닝 자전거', 'gyms-and-health-clubs_02s'),
        ('아령 세트 (10 개)', 'gyms-and-health-clubs_06s');
        
#운동 프로그램 명
delete from `sports_program`;
insert into `sports_program` (sp_name, sp_detail, sp_type)
	values
		('요가','스트레칭과 명상 중심의 프로그램으로 몸과 마음의 균형을 맞춥니다','그룹'),
        ('PT','1:1 강습으로 트레이너가 회원님을 친절하고 상세하게 관리해드립니다','단일'),
        ('필라테스','전문 트레이너와 1:1 강습으로 이쁜 몸매를 만들고 싶으신 분께 추천합니다','단일');
