<?php /* SYSKEYS $Id: do_sysval_aed.php 6038 2010-10-03 05:49:01Z ajdonnison $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

$del = isset($_POST['del']) ? $_POST['del'] : 0;
$obj = new CSysVal();

if (!$obj->bind($_POST)) {
	$AppUI->setMsg($obj->getError(), UI_MSG_ERROR);
	$AppUI->redirect();
}

$AppUI->setMsg("System Lookup Values", UI_MSG_ALERT);
if ($del) {
	if (($msg = $obj->delete())) {
		$AppUI->setMsg($msg, UI_MSG_ERROR);
	} else {
		$AppUI->setMsg("deleted", UI_MSG_ALERT, true);
	}
} else {
	if (($msg = $obj->store())) {
		$AppUI->setMsg($msg, UI_MSG_ERROR);
	} else {
		$AppUI->setMsg(@$_POST['sysval_id'] ? 'updated' : 'inserted', UI_MSG_OK, true);
	}
}
$AppUI->redirect("m=system&u=syskeys");
?>
