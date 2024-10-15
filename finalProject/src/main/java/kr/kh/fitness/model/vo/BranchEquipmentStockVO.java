package kr.kh.fitness.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 지점 헬스기구 재고 현황
 * */
@Data
@NoArgsConstructor
public class BranchEquipmentStockVO {
	private int be_num;           // 장비 재고 번호
    private int be_amount;        // 장비 수량
    private Date be_birth;        // 장비 출고일
    private Date be_record;       // 장비 기록일
    private String be_type;       // 장비 유형
    private String be_br_name;    // 지점 이름
    private String be_se_name;    // 스포츠 장비 이름
    private String be_birthStr;
    private String be_recordStr;

	public BranchEquipmentStockVO(int be_amount, Date be_birth, String be_type, String be_br_name, String be_se_name) {
		this.be_amount = be_amount;
		this.be_birth = be_birth;
		this.be_type = be_type;
		this.be_br_name = be_br_name;
		this.be_se_name = be_se_name;
	}
}