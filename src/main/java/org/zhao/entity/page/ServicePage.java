package org.zhao.entity.page;

import java.io.Serializable;

public class ServicePage extends Page implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8794684945926887839L;

	private String oSAccount;
	private String unixHost;
	private String identityCard;
	private String status;

	public String getoSAccount() {
		return oSAccount;
	}

	public void setoSAccount(String oSAccount) {
		this.oSAccount = oSAccount;
	}

	public String getUnixHost() {
		return unixHost;
	}

	public void setUnixHost(String unixHost) {
		this.unixHost = unixHost;
	}

	public String getIdentityCard() {
		return identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
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
		return "ServicePage [oSAccount=" + oSAccount + ", unixHost=" + unixHost
				+ ", identityCard=" + identityCard + ", status=" + status + "]";
	}

}
