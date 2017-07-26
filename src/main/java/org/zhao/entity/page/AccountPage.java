package org.zhao.entity.page;

import java.io.Serializable;

public class AccountPage extends Page implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2332166079129314273L;

	private String identityCard;
	private String nickname;
	private String realName;
	private String status;

	public String getIdentityCard() {
		return identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "AccountPage [identityCard=" + identityCard + ", nickname="
				+ nickname + ", realName=" + realName + ", status=" + status
				+ "]";
	}

}
