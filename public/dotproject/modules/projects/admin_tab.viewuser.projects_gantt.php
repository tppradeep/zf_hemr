<?php /* TASKS $Id: admin_tab.viewuser.projects_gantt.php 5972 2010-03-29 00:05:34Z merlinyoda $ */
if (!defined('DP_BASE_DIR')) {
	die('You should not access this file directly.');
}

global $company_id, $dept_ids, $department, $min_view, $m, $a, $user_id, $tab;

// reset the department and company filter info
// which is not used here
$company_id = $department = 0;
$projFilter_extra = array('-4' => 'All w/o archived');

require(DP_BASE_DIR.'/modules/projects/viewgantt.php');
?>
