#
# $Id: upgrade_20_to_201.sql 5924 2009-12-02 22:47:10Z merlinyoda $
# 
# DO NOT USE THIS SCRIPT DIRECTLY - USE THE INSTALLER INSTEAD.
#
# All entries must be date stamped in the correct format.
#

# 20050404 - minical config var restaured 
INSERT INTO `config` VALUES (null, 'cal_day_view_show_minical', 'true', '', 'checkbox');

# 20050405 - temporarily reset the memory limit for gantt charts
INSERT INTO `config` ( `config_id` , `config_name` , `config_value` , `config_group` , `config_type` )
	VALUES (null, 'reset_memory_limit', '32M', '', 'text');
