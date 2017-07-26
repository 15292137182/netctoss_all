


SELECT * FROM cost;
SELECT * FROM account;
SELECT * FROM service;
---
SELECT * FROM admin_info;
SELECT * FROM admin_role;
SELECT * FROM role_info;
SELECT * FROM role_module;
SELECT * FROM module_info;
---
SELECT * FROM role_info ri
LEFT JOIN admin_role ar ON ar.role_id=ri.role_id
LEFT JOIN admin_info ai ON ai.admin_id=ar.admin_id
WHERE ai.admin_id=10020
---
SELECT * FROM admin_info ai
LEFT JOIN admin_role ar ON ar.admin_id=ai.admin_id
LEFT JOIN role_info ri ON ri.role_id=ar.role_id
LEFT JOIN role_module rm ON rm.role_id=ri.role_id
LEFT JOIN module_info mi ON mi.module_id=rm.module_id
ORDER BY ai.admin_id DESC
---
SELECT * FROM admin_info ai
LEFT JOIN admin_role ar ON ar.admin_id=ai.admin_id
LEFT JOIN role_info ri ON ri.role_id=ar.role_id
WHERE ri.role_id=1014
---
DELETE FROM role_module WHERE role_id=1000
---
SELECT * FROM module_info mi
LEFT JOIN role_module rm ON rm.module_id=mi.module_id
LEFT JOIN role_info ri ON ri.role_id=rm.role_id
WHERE ri.role_id=100
---
UPDATE service
SET status='2'
WHERE service_id IN(2004,2007);
---
SELECT * FROM cost WHERE cost_id IN(
	SELECT cost_id FROM service WHERE service_id='2001'
)
---
SELECT * FROM (
	SELECT t.*,ROWNUM r FROM (
		SELECT s.service_id,s.account_id,s.os_username,s.status,s.unix_host,
		a.idcard_no,a.real_name,
		c.name,c.descr 
		FROM service s
		LEFT JOIN account a ON a.account_id=s.account_id
		LEFT JOIN cost c ON c.cost_id=s.cost_id
		ORDER BY s.create_date
		)t
	)WHERE r BETWEEN 1 AND 5
---
SELECT * FROM (
	SELECT t.*,ROWNUM r FROM (
		SELECT * FROM service
		ORDER BY create_date
		)t
	)WHERE r BETWEEN 1 AND 5
---
SELECT * FROM service s
LEFT JOIN account a ON a.account_id=s.account_id
LEFT JOIN cost c ON c.cost_id=s.cost_id
---
--1011:330902197108270429
--1010:330682196903190613
SELECT a.*,r.idcard_no rIdentityCard FROM account a
LEFT JOIN account r ON a.recommender_id=r.account_id
WHERE a.account_id=1011;
---
DELETE FROM account WHERE account_id=2003;
---
UPDATE cost
SET cost_type='2'
---
UPDATE account
SET status='2'
WHERE account_id IN(1010,1018,1021);
---
DELETE FROM admin_role WHERE admin_id=2000
---
DELETE FROM admin_role WHERE role_id=2000;
---
SELECT * FROM admin_role ORDER BY admin_id;
---
SELECT * FROM module_info WHERE module_id IN(
	SELECT module_id FROM role_module WHERE role_id=200
)
---
SELECT * FROM (
	SELECT t.*,ROWNUM r FROM (
		SELECT * FROM role_info
		ORDER BY role_id DESC
		)t
	)WHERE r BETWEEN 1 AND 3
---
SELECT * FROM role_info ri
LEFT JOIN role_module rm ON rm.role_id=ri.role_id
LEFT JOIN module_info mi ON mi.module_id=rm.module_id
---
UPDATE admin_info
SET token=#{token}
WHERE admin_id=#{admin_id}	
---
UPDATE admin_info
SET password='123'
WHERE admin_id IN(2000,3000)
---
SELECT * FROM module_info WHERE module_id IN(
	SELECT mi.module_id FROM module_info mi
	LEFT JOIN role_module rm ON rm.module_id=mi.module_id
	LEFT JOIN role_info ri ON ri.role_id=rm.role_id
	LEFT JOIN admin_role ar ON ar.role_id=ri.role_id
	LEFT JOIN admin_info ai On ai.admin_id=ar.admin_id
	WHERE ai.admin_id=2000
)
---
SELECT * FROM role_info WHERE role_id IN (
	SELECT role_id FROM admin_role WHERE admin_id=5000
)
---
SELECT COUNT(*) FROM admin_info WHERE admin_id IN(
	SELECT ai.admin_id FROM admin_info ai
	LEFT JOIN admin_role ar ON ar.admin_id=ai.admin_id
	LEFT JOIN role_info ri ON ri.role_id=ar.role_id
	LEFT JOIN role_module rm ON rm.role_id=ri.role_id
	LEFT JOIN module_info mi ON mi.module_id=rm.module_id
	WHERE ri.name LIKE '%经理%'
	)ORDER BY admin_id;
---
SELECT * FROM (
	SELECT t.*,ROWNUM r FROM (
		SELECT * FROM admin_info WHERE admin_id IN(
			SELECT ai.admin_id FROM admin_info ai
			LEFT JOIN admin_role ar ON ar.admin_id=ai.admin_id
			LEFT JOIN role_info ri ON ri.role_id=ar.role_id
			LEFT JOIN role_module rm ON rm.role_id=ri.role_id
			LEFT JOIN module_info mi ON mi.module_id=rm.module_id
			WHERE ri.name LIKE '%经理%'
			)ORDER BY admin_id
		)t
	)WHERE r BETWEEN 1 AND 3;
---
SELECT * FROM admin_info WHERE admin_id IN(
SELECT ai.admin_id FROM admin_info ai
LEFT JOIN admin_role ar ON ar.admin_id=ai.admin_id
LEFT JOIN role_info ri ON ri.role_id=ar.role_id
LEFT JOIN role_module rm ON rm.role_id=ri.role_id
LEFT JOIN module_info mi ON mi.module_id=rm.module_id
WHERE ri.name LIKE '%经理%'
)ORDER BY admin_id
---
SELECT * FROM admin_info WHERE admin_id IN(
SELECT ai.admin_id FROM admin_info ai
LEFT JOIN admin_role ar ON ar.admin_id=ai.admin_id
LEFT JOIN role_info ri ON ri.role_id=ar.role_id
LEFT JOIN role_module rm ON rm.role_id=ri.role_id
LEFT JOIN module_info mi ON mi.module_id=rm.module_id
WHERE mi.module_id=7
)ORDER BY admin_id
---
SELECT * FROM admin_info WHERE admin_id IN(
SELECT ai.admin_id FROM admin_info ai
LEFT JOIN admin_role ar ON ar.admin_id=ai.admin_id
LEFT JOIN role_info ri ON ri.role_id=ar.role_id
LEFT JOIN role_module rm ON rm.role_id=ri.role_id
LEFT JOIN module_info mi ON mi.module_id=rm.module_id
)ORDER BY admin_id
---
SELECT * FROM admin_info ai
LEFT JOIN admin_role ar ON ar.admin_id=ai.admin_id
LEFT JOIN role_info ri ON ri.role_id=ar.role_id
LEFT JOIN role_module rm ON rm.role_id=ri.role_id
LEFT JOIN module_info mi ON mi.module_id=rm.module_id
ORDER BY ai.admin_id;
---
SELECT * FROM (
	SELECT t.*,ROWNUM r FROM (
		SELECT * FROM admin_info
		ORDER BY admin_id
		)t
	)WHERE r BETWEEN 1 AND 3;
	
	
	
	
	

	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
