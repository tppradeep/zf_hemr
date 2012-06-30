<?php /* ADMIN $Id: do_perms_aed.php 5872 2009-04-25 00:09:56Z merlinyoda $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

$del = isset($_POST['del']) ? $_POST['del'] : 0;

$obj =& $AppUI->acl();

$AppUI->setMsg('Permission');
if ($del) {
	if ($obj->del_acl($_REQUEST['permission_id'])) {
		$AppUI->setMsg("deleted", UI_MSG_ALERT, true);
		$AppUI->redirect();
	} else {
		$AppUI->setMsg($obj->msg(), UI_MSG_ERROR);
		$AppUI->redirect();
	}
} else {
	// No longer have update, only add, also addRolePermssion is
	// no longer different to addUserPermission.
	if ($obj->addUserPermission()) {
		$AppUI->setMsg('added', UI_MSG_OK, true);
	} else {
		$AppUI->setMsg($obj->msg(), UI_MSG_ERROR);
	}
	$AppUI->redirect();
}
?>
