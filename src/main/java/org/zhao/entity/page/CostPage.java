package org.zhao.entity.page;

import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component
public class CostPage extends Page implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8501109308127220060L;

	private String baseDuration;
	private String baseCost;

	public String getBaseDuration() {
		return baseDuration;
	}

	public void setBaseDuration(String baseDuration) {
		this.baseDuration = baseDuration;
	}

	public String getBaseCost() {
		return baseCost;
	}

	public void setBaseCost(String baseCost) {
		this.baseCost = baseCost;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "CostPage [baseDuration=" + baseDuration + ", baseCost="
				+ baseCost + "]";
	}

}
