


<?xml version="1.0" encoding="UTF-8" ?>  
<!DOCTYPE mapper PUBLIC "-//ibatis.apache.org//DTD Mapper 3.0//EN"      
 "http://ibatis.apache.org/dtd/ibatis-3-mapper.dtd">
<mapper namespace="">
</mapper>


<%@page pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<script type="text/javascript" src="../js/jquery-1.11.3.js"></script>


<?xml version="1.0"  encoding="UTF-8"?>


<resultMap type="" id="">
		<!-- 
			一对多关联映射时,主键字段必须显示装配,不能省略;
			id指的是当前装配的是主键列;
			column指的是主键列的列名;
			property指的是对应的属性名.
			其他的列和属性同名,是可以省略的.		
		 -->
		<id column="" property=""></id>
		<!-- 
			collection指的是要自动装配一个集合;
			select指的是该装配需要调用的sql;
			column指的是查询数据时需要的条件来源,
				即查询表结果中的某一列列名;
			javaType指的是关联数据封装的集合类型;
			ofType指的是集合中的对象类型;
			property指的是集合数据注入给哪个属性;
		 -->
		<collection property=""
			column=""
			javaType=""
			ofType=""
			select="">
		</collection>
</resultMap>

<selectKey keyProperty=""
			order=""
			resultType="">
			
</selectKey>
		
<foreach collection=""
			item=""
			open=""
			separator=""
			close="">
			
</foreach>

<choose>
	<!-- 任意排序条件非空时，按条件排序 -->
	<when test="">
		<trim suffixOverrides="">
			<if test=''>
				,
			</if>
			<if test=''>
				,
			</if>
			<if test=''>
				,
			</if>
			<if test=''>
				,
			</if>
		</trim>
	</when>
	<!-- 默认按照ID排序 -->
	<otherwise>
		
	</otherwise>
</choose>



























