<?php /* $Id: vw_log_update.php,v 1.4 2004/04/29 14:12:07 agorski Exp $ */
GLOBAL $AppUI, $hditem, $ist;
$item_id = dPgetParam( $_GET, 'item_id', 0 );
// check permissions
//$canEdit = !getDenyEdit( 'tasks', $item_id );
//if (!$canEdit) {
//	$AppUI->redirect( "m=public&a=access_denied" );
//}

$task_log_id = intval( dPgetParam( $_GET, 'task_log_id', 0 ) );
$log = new CTaskLog();
if ($task_log_id) {
	$log->load( $task_log_id );
} else {
	$log->task_log_help_desk_id = $item_id;
	$log->task_log_name = $hditem['item_title'];
}

// Lets check which cost codes have been used before
$sql = "select distinct task_log_costcode
        from task_log
        where task_log_costcode != ''
        order by task_log_costcode";
$task_log_costcodes = array(""); // Let's add a blank default option
$task_log_costcodes = array_merge($task_log_costcodes, db_loadColumn($sql));

//if ($canEdit) {
// Task Update Form
	$df = $AppUI->getPref( 'SHDATEFORMAT' );
	$log_date = new CDate( $log->task_log_date );

	if ($task_log_id) {
		echo $AppUI->_( "Edit Log" );
	} else {
		echo $AppUI->_( "Add Log" );
	}
?>

<!-- TIMER RELATED SCRIPTS -->
<script language="JavaScript">
	// please keep these lines on when you copy the source
	// made by: Nicolas - http://www.javascript-page.com
	// adapted by: Juan Carlos Gonzalez jcgonz@users.sourceforge.net
	
	var timerID       = 0;
	var tStart        = null;
    var total_minutes = -1;
	
	function UpdateTimer() {
	   if(timerID) {
	      clearTimeout(timerID);
	      clockID  = 0;
	   }
	
       // One minute has passed
       total_minutes = total_minutes+1;
	   
	   document.getElementById("timerStatus").innerHTML = "( "+total_minutes+" <?php echo $AppUI->_('minutes elapsed'); ?> )";

	   // Lets round hours to two decimals
	   var total_hours   = Math.round( (total_minutes / 60) * 100) / 100;
	   document.editFrm.task_log_hours.value = total_hours;
	   
	   timerID = setTimeout("UpdateTimer()", 60000);
	}
	
	function timerStart() {
		if(!timerID){ // this means that it needs to be started
			document.editFrm.timerStartStopButton.value = "<?php echo $AppUI->_('Stop');?>";
            UpdateTimer();
		} else { // timer must be stoped
			document.editFrm.timerStartStopButton.value = "<?php echo $AppUI->_('Start');?>";
			document.getElementById("timerStatus").innerHTML = "";
			timerStop();
		}
	}
	
	function timerStop() {
	   if(timerID) {
	      clearTimeout(timerID);
	      timerID  = 0;
          total_minutes = total_minutes-1;
	   }
	}
	
	function timerReset() {
		document.editFrm.task_log_hours.value = "0.00";
        total_minutes = -1;
	}
	
</script>
<!-- END OF TIMER RELATED SCRIPTS -->


<table cellspacing="1" cellpadding="2" border="0" width="100%">
<form name="editFrm" action="?m=helpdesk&a=view&item_id=<?php echo $item_id;?>" method="post">
	<input type="hidden" name="uniqueid" value="<?php echo uniqid("");?>" />
	<input type="hidden" name="dosql" value="do_item_aed" />
	<input type="hidden" name="item_id" value="<?php echo $item_id;?>" />
	<input type="hidden" name="task_log" value="1" />
	<input type="hidden" name="task_log_id" value="<?php echo $log->task_log_id;?>" />
	<input type="hidden" name="task_log_help_desk_id" value="<?php echo $item_id;?>" />
	<input type="hidden" name="task_log_creator" value="<?php echo $AppUI->user_id;?>" />
	<input type="hidden" name="task_log_name" value="Update :<?php echo $log->task_log_name;?>" />
<tr>
	<td nowrap="nowrap">
		<?php echo $AppUI->_('Date');?><br>
	<!-- patch by rowan  bug #890841 against v1.0.2-1   email: bitter at sourceforge dot net -->
		<input type="hidden" name="task_log_date" value="<?php echo $log_date->format( FMT_DATETIME_MYSQL );?>">
	<!-- end patch #890841 -->
		<input type="text" name="log_date" value="<?php echo $log_date->format( $df );?>" class="text" disabled="disabled">
		<a href="#" onClick="popCalendar('log_date')">
			<img src="./images/calendar.gif" width="24" height="12" alt="<?php echo $AppUI->_('Calendar');?>" border="0" />
		</a>
	</td>
	<td><?php echo $AppUI->_('Summary');?>:<br>
		<input type="text" class="text" name="task_log_name" value="<?php echo $log->task_log_name;?>" maxlength="255" size="30" />
	</td>
</tr>
<tr>
      <td><?=$AppUI->_('Status')?>:<br><?=arraySelect( $ist, 'item_status', 'size="1" class="text" id="medium"',@$hditem["item_status"] )?></td>
	<td rowspan="3">
	<?php echo $AppUI->_('Description');?>:<br>
		<textarea name="task_log_description" class="textarea" cols="30" rows="6"><?php echo $log->task_log_description;?></textarea>
	</td>
</tr>
<tr>
	<td>
		<?php echo $AppUI->_('Hours Worked');?><br>
		<input type="text" class="text" name="task_log_hours" value="<?php echo $log->task_log_hours;?>" maxlength="8" size="6" /> 
		<input type='button' class="button" value='<?php echo $AppUI->_('Start');?>' onclick='javascript:timerStart()' name='timerStartStopButton' />
		<input type='button' class="button" value='<?php echo $AppUI->_('Reset'); ?>' onclick="javascript:timerReset()" name='timerResetButton' /> 
		<span id='timerStatus'></span>
	</td>
</tr>
<tr>
	<td>
		<?php echo $AppUI->_('Cost Code');?>:<br>
<?php
		echo arraySelect( $task_log_costcodes, 'task_log_costcodes', 'size="1" class="text" onchange="javascript:task_log_costcode.value = this.options[this.selectedIndex].text;"', '' );
?>
		&nbsp;->&nbsp; <input type="text" class="text" name="task_log_costcode" value="<?php echo $log->task_log_costcode;?>" maxlength="8" size="8" />
	</td>
</tr>
<tr>
	<td colspan="2" valign="bottom" align="right">
		<input type="submit" class="button" value="<?php echo $AppUI->_($task_log_id?'update task log':'create task log');?>" onclick="" />
	</td>
</tr>

</form>
</table>
<?php //}
?>
