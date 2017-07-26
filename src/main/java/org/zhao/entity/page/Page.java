package org.zhao.entity.page;

import java.io.Serializable;
import java.util.Map;

import org.zhao.util.InitPageXml;

public class Page implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3979864584215814518L;
	private Integer begin;
	private Integer end;
	private static Integer currentPage;
	private static Integer pageSize;
	private Integer rows;
	private Integer totalPage;

	/**
	 * 两种方法: 
	 * 方法一在applicationContext配置文件;
	 * 以下为方法二:
	 */
	static {
		getPage();// 方法二
	}

	public static void getPage() {
		Map<String, String> map = InitPageXml.getPageXml();
		currentPage = Integer.valueOf(map.get("currentPage"));
		pageSize = Integer.valueOf(map.get("pageSize"));
	}

	public Integer getBegin() {
		begin = (currentPage - 1) * pageSize + 1;
		return begin;
	}

	public void setBegin(Integer begin) {
		this.begin = begin;
	}

	public Integer getEnd() {
		end = currentPage * pageSize;
		return end;
	}

	public void setEnd(Integer end) {
		this.end = end;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Integer getTotalPage() {
		if (rows % pageSize == 0) {
			return totalPage = rows / pageSize;
		}
		return totalPage = rows / pageSize + 1;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Page [begin=" + begin + ", end=" + end + ", currentPage="
				+ currentPage + ", pageSize=" + pageSize + ", rows=" + rows
				+ ", totalPage=" + totalPage + "]";
	}

}
