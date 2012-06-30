<?php /* HELPDESK $Id: index.php,v 1.8 2007/08/22 07:17:43 arcoz67 Exp $ */

// Register position of New Task Log tab so we can call it correctly from the vw_timecard report
// If you change the tab order you'll need to modify this global in two places below
// (There is probably a better way to do this...)

global $newTLogTabNum;
$newTLogTabNum = 2;

// check permissions
$denyRead = getDenyRead($m);
$denyEdit = getDenyEdit($m);

if ($denyRead) {
	$AppUI->redirect("m=help&a=access_denied");
}

$TIMECARD_CONFIG = array();
require_once "./modules/timecard/config.php";

// setup the title block
$titleBlock = new CTitleBlock('Time Card', 'TimeCard.png', $m, "$m.$a");

$titleBlock->show();

if (isset( $_GET['tab'] )) {
	$AppUI->setState('TimecardVwTab', $_GET['tab']);
}
$tab = $AppUI->getState('TimecardVwTab') ? $AppUI->getState('TimecardVwTab') : 0;

$tabBox = new CTabBox("?m=timecard", "./modules/timecard/", $tab);
$tabBox->add('vw_timecard', 'Weekly Time Card');
$tabBox->add('vw_calendar_by_user', 'Task Logs by Date');
if ($TIMECARD_CONFIG['minimum_report_level'] >= $AppUI->user_type) {
  $tabBox->add('vw_weekly_by_user', 'Summary by User');
	$tabBox->add('vw_weekly_by_project', 'Summary by Project');
  $newTLogTabNum = 4;
}
$tabBox->add('vw_newlog', 'New Task Log');
if ($TIMECARD_CONFIG['integrate_with_helpdesk']) {
	//$tabBox->add( 'vw_newhelpdesklog', 'New Helpdesk Log' );
}

$tabBox->show();
?>