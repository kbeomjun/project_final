package kr.kh.fitness.model.dto;

import lombok.Data;

@Data // parsing 할때 getter setter 필요
public class OAuthToken {

	// 스펠링이 틀리지 않도록 조심하자
	private String access_token;
	private String token_type;
	private String refresh_token;
	private int expires_in;
	private String scope;
	private int refresh_token_expires_in;
}
