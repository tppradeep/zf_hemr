<?php /* HELPDESK $Id: vw_newhelpdesklog.php,v 1.13 2007/08/22 07:17:43 arcoz67 Exp $ */
//THIS TAB IS NOT CURRENTLY FUNCTIONAL for current CVS of HelpDesk (as of 1:31 PM 2007-08-22)

//Based largely on the page with the same funtion in the existing TimeTrack module by ajdonnison.  

// check permissions
$m = $AppUI->checkFileName(dPgetParam( $_GET, 'm', getReadableModule() ));
$denyEdit = getDenyEdit( $m );
if ($denyEdit) {
	$AppUI->redirect( "m=public&a=access_denied" );
}


require_once $AppUI->getSystemClass('date');
//require_once $AppUI->getModuleClass('helpdesk');
$df = $AppUI->getPref('SHDATEFORMAT');

$tid = isset($_GET['tid']) ? $_GET['tid'] : 0;

//pull data 
// if we have a TID, then we editing an existing row
$sql = " 
SELECT dotp_task_log.*, item_id, item_project_id, item_title, item_company_id 
FROM dotp_task_log
LEFT JOIN helpdesk_items ON task_log_help_desk_id = item_id
WHERE  task_log_id = $tid 
AND ".getItemPerms()."
"; 
echo "<pre>$sql</pre>";
echo '<pre>';print_r($sql);echo '</pre>';

db_loadHash( $sql, $helpdeskItemTask );

$is_new_record = !$tid;
$helpdeskItemTask_found = $helpdeskItemTask['item_id']!=FALSE;
$require_task_info = $is_new_record || $helpdeskItemTask_found;
//echo '<pre>';print_r($helpdeskItemTask);echo '</pre>';

Global $TIMECARD_CONFIG;
//Prevent users from editing other ppls timecards.
$can_edit_other_timesheets = $TIMECARD_CONFIG['minimum_edit_level']>=$AppUI->user_type;
if (!$can_edit_other_timesheets){
	if(isset($_GET['tid']) && ((isset($helpdeskItemTask['task_log_creator']) && $helpdeskItemTask['task_log_creator'] != $AppUI->user_id)) ){
		$AppUI->redirect( "m=public&a=access_denied" );
	}
}

$AppUI->savePlace();

if (isset( $helpdeskItemTask['task_log_date'] )) {
	$date = new CDate( $helpdeskItemTask['task_log_date'] ); 
} else if (isset( $_GET['date'] )) {
	$date = new CDate($_GET['date']); 
} else {
	$date = new CDate();
}

// get user -> help desk items
$sql = "
SELECT h.*, p.project_name, c.company_name, c.company_id
FROM helpdesk_items h
LEFT JOIN dotp_projects p ON h.item_project_id = p.project_id 
LEFT JOIN dotp_companies c ON h.item_company_id = c.company_id
WHERE ".getItemPerms()."
ORDER by p.project_name, h.item_title
";
//echo "<pre>$sql</pre>";

$res = db_exec( $sql );
echo db_error();
$helpdeskItemTasks = array();
$project = array();
$companies = array();
while ($row = db_fetch_assoc( $res )) {
// collect help desk items in js format
	$helpdeskItemTasks[$row['item_id']] = "[{$row['item_project_id']},{$row['item_id']},'".addslashes($row['item_title'])."',{$row['item_company_id']}]";
// collect projects in js format
	$projects[$row['item_project_id']] = "[{$row['company_id']},{$row['item_project_id']},'".addslashes($row['project_name'])."']";
// collect companies in normal format
	$companies[$row['item_company_id']] = $row['company_name'];
};
//echo '<pre>';print_r($companies);echo '</pre>';
//echo '<pre>';print_r($helpdeskItemTask['item_company_id']);echo '</pre>';

if ($helpdeskItemTask_found)
{
	// need to add the entry for the helpdesk itself as that was not found
	$helpdeskItemTasks[$helpdeskItemTask['item_id']] = "[{$helpdeskItemTask['item_project_id']}, {$helpdeskItemTask['item_id']}, '{$helpdeskItemTask['item_title']}', {$helpdeskItemTask['item_company_id']}]";
	// get the project name
	$sql = "SELECT project_name FROM dotp_projects WHERE project_id = ".$helpdeskItemTask['item_project_id'];
	$itemCompanyName = db_LoadResult($sql);
	// collect projects in js format
	$projects[$helpdeskItemTask['item_project_id']] = "[{$helpdeskItemTask['item_company_id']},{$helpdeskItemTask['item_project_id']}, '{$itemCompanyName}']";
	// get the company name
	$sql = "SELECT company_name FROM dotp_companies WHERE company_id = ".$helpdeskItemTask['item_company_id'];
	// collect companies in normal format
	$companies[$helpdeskItemTask['item_company_id']] =  db_LoadResult($sql);
}

// pull in the companies
//$sql = "SELECT company_id, company_name FROM companies ORDER BY company_name";
//$companies = arrayMerge( array( '0'=>'' ), db_loadHashList( $sql ) );

##
## Set up JavaScript arrays
##
$ua = $_SERVER['HTTP_USER_AGENT'];
$isMoz = strpos( $ua, 'Gecko' ) !== false;

if(isset($projects)){
	$projects = array_unique( $projects );
	reset( $projects );
} else {
	$projects = array();
}

$s = "\nvar helpDeskItems = new Array(".implode( ",\n", $helpdeskItemTasks ).")";
$s .= "\nvar projects = new Array(".implode( ",\n", $projects ).")";

echo "<script language=\"javascript\">$s</script>";
?>

<script language="javascript">

var calendarField = '';

function popCalendar( field ){
	calendarField = field;
	uts = eval( 'document.AddEdit.task_log_' + field + '.value' );
	window.open( 'index.php?m=public&a=calendar&dialog=1&callback=setCalendar&uts=' + uts, 'calwin', 'top=250,left=250,width=250, height=220, scollbars=false' );
}

function setCalendar( uts, fdate ) {
	fld_uts = eval( 'document.AddEdit.task_log_' + calendarField );
	fld_fdate = eval( 'document.AddEdit.' + calendarField );
	fld_uts.value = uts;
	fld_fdate.value = fdate;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// List Handling Functions
function emptyList( list ) {
<?php if ($isMoz) { ?>
	list.options.length = 0;
<?php } else { ?>
	while( list.options.length > 0 )
		list.options.remove(0);
<?php } ?>
}

function addToList( list, text, value ) {
	//alert( list+','+text+','+value );
<?php if ($isMoz) { ?>
	list.options[list.options.length] = new Option(text, value);
<?php } else { ?>
	var newOption = document.createElement("OPTION");
	newOption.text = text;
	newOption.value = value;
	list.add( newOption, 0 );
<?php } ?>
}

function changeList( listName, source, target, source_field_index ) {
	//alert(listName+','+source+','+target);return;
	var f = document.AddEdit;
	var list = eval( 'f.'+listName );
	
	// clear the options
	emptyList( list );
	
	// refill the list based on the target
	// add a blank first to force a change
	addToList( list, '', '0' );
	for (var i=0, n = source.length; i < n; i++) {
		if( source[i][source_field_index] == target ) {
			addToList( list, source[i][2], source[i][1] );
		}
	}
}

// select an item in the list by target value
function selectList( listName, target ) {
	var f = document.AddEdit;
	var list = eval( 'f.'+listName );

	for (var i=0, n = list.options.length; i < n; i++) {
//alert(listName+','+target+','+list.options[i].value);
		if( list.options[i].value == target ) {
			list.options.selectedIndex = i;
			return;
		}
	}
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function submitIt() {
	var f = document.AddEdit;
 	var chours = parseFloat( f.task_log_hours.value );
	if(f.task_log_help_desk_id){
		f.task_log_name.value = f.task_log_help_desk_id.options[f.task_log_help_desk_id.selectedIndex].text;
	}
	
	if (f.task_log_hours.value.length < 1) {
		alert( "Please enter hours worked" );
		f.task_log_hours.focus();
	} else if (chours > 24) {
		alert( "Hours cannot exceed 24" );
		f.task_log_hours.focus();
	} else if (f.task_log_description.value.length<1) {
		alert( "Please enter a worthwhile comment." );
		f.task_log_description.focus();
	} else if ((f.task_log_help_desk_id.options[f.task_log_help_desk_id.selectedIndex].value==0) && (f.require_task_info.value=="true")){
		alert( "You must select a Help Desk Item." );
		f.task_log_help_desk_id.focus();
	} else {
		f.submit();
	}
}

function delIt() {
	if (confirm( "Are you sure that you would like to delete this task log?\n" )) {
		var form = document.AddEdit;
		form.del.value=1;
		form.submit();
	}
}
</script>

<form name="AddEdit" action="" method="post">
<input type="hidden" name="m" value="timecard">
<input type="hidden" name="tab" value="0">
<input type="hidden" name="dosql" value="do_updatetasklog">
<input type="hidden" name="del" value="0">
<input type="hidden" name="require_task_info" value="<?php echo ($require_task_info ? "true" : "false"); ?>">
<input type="hidden" name="task_log_id" value="<?php echo (($tid > 0) ? $tid : "0"); ?>">
<?php
	if ($tid)
	{
		// maintain existing creator
		echo "<input type='hidden' name='task_log_creator' value=".$helpdeskItemTask['task_log_creator']."/>";
	}
	else
	{
		echo "<input type='hidden' name='task_log_creator' value=".$AppUI->user_id."/>";
	}
?>
 
<?php 
	if(!$is_new_record && $helpdeskItemTask_found){
?>
<table border="0" cellpadding="4" cellspacing="0" width="98%">
<tr>
	<td width="50%" align="right">
		<A href="javascript:delIt()"><img align="absmiddle" src="./images/icons/stock_delete-16.png" width="16" height="16" alt="Delete this project" border="0"><?php echo $AppUI->_('delete task log');?></a>
	</td>
</tr>
</table>
<?php 
	}
?>

<table cellspacing="0" cellpadding="4" border="0" width="98%" class="std">
<tr>
	<th colspan="2"><?php echo $tid?$AppUI->_('Editing'):$AppUI->_('Creating New')." ".$AppUI->_('Help Desk Log'); ?> </th>
</tr>
<?php
/*	
	if($tid && (!@$helpdeskItemTask['item_company_id'] || !@$helpdeskItemTask['item_project_id'] || !@$helpdeskItemTask['task_log_help_desk_id'])){
?>
	<td align="right" nowrap="nowrap">Task Description:</td>
	<td>
		<input type="text" name="task_log_name" value="<?php echo @$helpdeskItemTask['task_log_name'] ;?>" class="text"> * The company, project or task that this time was logged against has been deleted.
	</td>
<?php
	} else {
*/
?>
<tr>
	<td align="right" nowrap="nowrap"><?php echo $AppUI->_('Entity');?>:</td>
	<td>
	<?php
		$params = 'size="1" class="text" style="width:250px" ';
		$params .= 'onchange="changeList(\'item_project_id\',projects, this.options[this.selectedIndex].value,0);changeList(\'task_log_help_desk_id\',helpDeskItems, this.options[this.selectedIndex].value,3)"';
		echo arraySelect( $companies, 'item_company_id', $params, @$helpdeskItemTask['item_company_id'] );
	?>
	</td>
</tr>
<tr>
	<td align="right" nowrap="nowrap"><?php echo $AppUI->_('Project');?>:</td>
	<td>
		<select name="item_project_id" class="text" style="width:250px" onchange="changeList('task_log_help_desk_id',helpDeskItems, this.options[this.selectedIndex].value,0)"></select>
	</td>
</tr>
<tr>
	<td align="right" nowrap="nowrap"><?php echo $AppUI->_('Help Desk Item');?>* :</td>
	<td>
		<select name="task_log_help_desk_id" class="text" style="width:250px"></select>
		<input type="hidden" name="task_log_name" value="">
	</td>
</tr>
<?php
//	}
?>
<tr>
	<td align="right" nowrap="nowrap"><?php echo $AppUI->_('Date');?>* :</td>
	<td>
		<input type="hidden" name="task_log_date" value="<?php echo $date->getDate();?>">
		<input type="text" name="date" value="<?php echo $date->format($df);?>" class="text" disabled="disabled">
		<a href="#" onClick="popCalendar('date')">
			<img src="./images/calendar.gif" width="24" height="12" alt="<?php echo $AppUI->_('Calendar');?>" border="0">
		</a>

	</td>
</tr>
<tr>
	<td align="right" nowrap="nowrap"><?php echo $AppUI->_('Hours');?>* :</td>
	<td>
		<input type="text" name="task_log_hours" value="<?php echo (($tid > 0) ? $helpdeskItemTask["task_log_hours"] : "");?>" class="text" size="4" maxlength="10">
	</td>

</tr>
<tr>
	<td align="right" valign="top" nowrap="nowrap"><?php echo $AppUI->_('Description');?>* :</td>
	<td align="left">
		<textarea name="task_log_description" cols="60" rows="6" wrap="virtual" class="textarea"><?php echo (($tid > 0) ? $helpdeskItemTask["task_log_description"] : "");?></textarea>
	</td>
</tr>
<tr>
	<td>
		<input class="button" type="Button" name="Cancel" value="cancel" onClick="javascript:if(confirm('Are you sure you want to cancel.')){location.href = './index.php?m=timecard&tab=0';}">
	</td>
	<td align="right">
		<input class="button" type="Button" name="btnFuseAction" value="save" onClick="submitIt();">
	</td>
</tr>
</table>
</form>
* indicates required field
<script language="javascript">
changeList('item_project_id', projects, <?php echo @$helpdeskItemTask['item_company_id'] ? $helpdeskItemTask['item_company_id'] : 0;?>,0);
changeList('task_log_help_desk_id', helpDeskItems, <?php echo @$helpdeskItemTask['item_project_id'] ? $helpdeskItemTask['item_project_id'] : 0;?>,3);

selectList( 'item_company_id', <?php echo @$helpdeskItemTask['item_company_id'] ? $helpdeskItemTask['item_company_id'] : 0;?> );
selectList( 'item_project_id', <?php echo @$helpdeskItemTask['item_project_id'] ? $helpdeskItemTask['item_project_id'] : 0;?> );
selectList( 'task_log_help_desk_id', <?php echo @$helpdeskItemTask['task_log_help_desk_id'] ? $helpdeskItemTask['task_log_help_desk_id'] : 0;?> );
</script>
