package kr.kh.fitness.model.dto;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BranchStockDTO {
	private String be_se_name;
	private int be_se_total;
	private String be_se_fi_name;
    private Date be_birth;
}