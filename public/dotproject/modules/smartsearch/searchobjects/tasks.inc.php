<?php /* SMARTSEARCH$Id: tasks.inc.php 6038 2010-10-03 05:49:01Z ajdonnison $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

/**
* tasks Class
*/
class tasks extends smartsearch 
{
	var $table = 'tasks';
	var $table_module = 'tasks';
	var $table_key = 'task_id';
	var $table_link = '?m=tasks&amp;a=view&amp;task_id=';
	var $table_title = 'Tasks';
	var $table_orderby = 'task_name';
	var $search_fields = array('task_name', 'task_description', 'task_related_url', 
	                           'task_departments', 'task_contacts', 'task_custom');
	var $display_fields = array('task_name', 'task_description', 'task_related_url', 
	                            'task_departments', 'task_contacts', 'task_custom');

	function ctasks () {
		return new tasks();
	}
}
?>
