package org.zhao.entity.page;

import java.io.Serializable;
import java.util.List;

import org.zhao.entity.Role;

public class AdminPage extends Page implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6496586110171140168L;

	private Integer moduleId;
	private String roleName;

	public Integer getModuleId() {
		return moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "AdminPage [moduleId=" + moduleId + ", roleName=" + roleName
				+ "]";
	}

}
