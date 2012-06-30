<?php /* HELPDESK $Id: vw_timecard.php,v 1.13 2007/08/22 07:17:43 arcoz67 Exp $ */

	Global $TIMECARD_CONFIG,$newTLogTabNum;
	
	$m = $AppUI->checkFileName(dPgetParam( $_GET, 'm', getReadableModule() ));
	$denyEdit = getDenyEdit( $m );
	if ($denyEdit) {
		$AppUI->redirect( "m=public&a=access_denied" );
	}

	//grab hours per day from config
	$min_hours_day = $AppUI->cfg['daily_working_hours'];
	$can_edit_other_timesheets = $TIMECARD_CONFIG['minimum_edit_level']>=$AppUI->user_type;
	$show_other_worksheets = $TIMECARD_CONFIG['minimum_see_level']>=$AppUI->user_type;
	$integrate_with_helpdesk = $TIMECARD_CONFIG['integrate_with_helpdesk'];
	$show_possible_hours_worked = $TIMECARD_CONFIG['show_possible_hours_worked'];
	//print "<pre>";
	//print_r($AppUI);
	//print "</pre>";
	
		
	//compute hours/week from config
	$min_hours_week =count(explode(",",dPgetConfig("cal_working_days"))) * $min_hours_day;
	
	// get date format
	$df = $AppUI->getPref('SHDATEFORMAT');

	if (isset( $_GET['user_id'] )) {
	//if (isset( $AppUI->user_id )) {
	
		$sql = "SELECT user_contact FROM dotp_users WHERE user_id = ".$_GET['user_id'];
		$contact_id = db_loadResult( $sql );
		$sql = "SELECT contact_company FROM dotp_contacts WHERE contact_id = ".$contact_id;
		//print $sql;
		$company_id = db_loadResult( $sql );
		//print $company_id.":".getDenyRead( "companies", $company_id );
		//Comment out the 3 lines below to skip the company check
    if(getDenyRead( "companies", $company_id )){
    $AppUI->redirect( "m=public&a=access_denied" );
    }
    
		$AppUI->setState( 'TimecardSelectedUser', $_GET['user_id'] );
	}
	$user_id = $AppUI->getState( 'TimecardSelectedUser' ) ? $AppUI->getState( 'TimecardSelectedUser' ) : $AppUI->user_id;

	$AppUI->savePlace();

	if (isset( $_GET['start_date'] )) {
		$AppUI->setState( 'TimecardStartDate', $_GET['start_date'] );
	}
	$start_day = new CDate( $AppUI->getState( 'TimecardStartDate' ) ? $AppUI->getState( 'TimecardStartDate' ) : NULL);

	//set the time to noon to combat a php date() function bug that was adding an hour.
	$date = $start_day->format("%Y-%m-%d")." 12:00:00";
	$start_day -> setDate($date, DATE_FORMAT_ISO);
	
	$today_weekday = $start_day -> getDayOfWeek();

	//roll back to the first day of that week, regardless of what day was specified
	$rollover_day = '0';
	$new_start_offset = $rollover_day - $today_weekday;
	$start_day -> addDays($new_start_offset);

	//last day of that week, add 6 days
	$end_day = new CDate ();
	$end_day -> copy($start_day);
	$end_day -> addDays(6);

	//date of the first day of the previous week.
	$prev_date = new CDate ();
	$prev_date -> copy($start_day);
	$prev_date -> addDays(-7);

	//date of the first day of the next week.
	$next_date = new CDate ();
	$next_date -> copy($start_day);
	$next_date -> addDays(7);
	
	//***MOD 20050525 pedroa 
	//$is_my_timesheet = $user_id == $AppUI->user_id;
	$is_my_timesheet = ($user_id == $AppUI->user_id || $can_edit_other_timesheets);
	
	?>
	<form name="user_select" method="get">
	<input type="hidden" name="m" value="timecard">
	<input type="hidden" name="tab" value="0">
	<input type="hidden" name="start_date" value="<?php echo $start_day->getDate();?>">
	<table align="center">
		<tr>
			<td><a href="?m=timecard&user_id=<?php echo $user_id;?>&start_date=<?php echo urlencode($prev_date->getDate()) ;?>"><img src="./images/prev.gif" width="16" height="16" alt="<?php echo $AppUI->_( 'previous' );?>" border="0"></a></td>
			<td><b>
	<?php
	echo $start_day -> getDayName(false). " " .$start_day->format( $df )."</b> ".$AppUI->_('through')." <b>".$end_day -> getDayName(false). " " .$end_day->format( $df );
	?>
			</b></td>
			<td><a href="?m=timecard&user_id=<?php echo $user_id;?>&start_date=<?php echo urlencode($next_date->getDate()) ;?>"><img src="./images/next.gif" width="16" height="16" alt="<?php echo $AppUI->_( 'next' );?>" border="0"></a></td>
	<?php
		if($show_other_worksheets){
	?>
			<td align="right">
					<select name="user_id" onChange="document.user_select.submit();">
	<?php
		//$sql = "SELECT user_id, user_username, user_last_name 
		//FROM users WHERE user_id=".$AppUI->user_id." or (".getPermsWhereClause("companies", "user_company").") ORDER BY user_last_name, user_first_name";
		$sql = "SELECT dotp_users.user_contact,dotp_users.user_id,dotp_contacts.contact_first_name,dotp_contacts.contact_last_name,dotp_contacts.contact_id
		FROM dotp_users
		inner JOIN dotp_contacts on contact_id = user_contact
		WHERE dotp_users.user_contact = ".$AppUI->user_id." or (".getPermsWhereClause("companies", "user_company").") ORDER BY contact_first_name, contact_last_name";
		
		$result = db_loadList($sql);
		foreach ($result as $user) {
			echo "<option value=\"".$user["user_id"]."\"".($user["user_id"]==$user_id?"selected":"").">".$user["contact_first_name"]." ".$user["contact_last_name"]."</option>\n";
		}
	?>
					</select>
			</td>
			<td align="left" nowrap="nowrap"><a href="?m=timecard&tab=0&user_id=<?php echo $AppUI->user_id; ?>">[My Time Card]</a></td>
	<?php
		}
	?>
		</tr>
	<?php
	?>
	<table width="100%" border="0" cellpadding="2" cellspacing="1" class="tbl">
		<tr>
			<!--
			<td rowspan="11" width="1%" align="center"><span style="font-family=monospace">M o n d a y</span></td>
			<th width="1%"><?php echo $AppUI->_('Task Date'); ?></th>
			-->
			<th width="1%"><?php echo $AppUI->_('Task Name'); ?></th>
			<th width="85%"><?php echo $AppUI->_('Log Entry'); ?></th>
			<th width="14%"><?php echo $AppUI->_('Hours'); ?></th>
		</tr>
	<?php
	//set the time the beginning of the first day and end of the last day.
	$date = $start_day->format("%Y-%m-%d")." 00:00:00";
	$start_day -> setDate($date, DATE_FORMAT_ISO);
	$date = $end_day->format("%Y-%m-%d")." 23:59:59";
	$end_day -> setDate($date, DATE_FORMAT_ISO);
  //12:23 AM 2007-08-06 Query modified to use task name rather than task summary
	$sql = "SELECT dotp_task_log.*, dotp_tasks.task_id, dotp_tasks.task_name
		FROM 
			dotp_task_log 
			LEFT JOIN dotp_tasks on dotp_task_log.task_log_task = dotp_tasks.task_id
		WHERE "
		." task_log_creator=".$user_id." AND"
		." task_log_date >= \"".$start_day->format( FMT_DATETIME_MYSQL )."\" AND "
		." task_log_date <= \"".$end_day->format( FMT_DATETIME_MYSQL )."\" "
		." ORDER BY task_log_date";
//print "<pre>$sql</pre>";
	$result = db_loadList($sql);
	$date = $start_day->format("%Y-%m-%d")." 12:00:00";
	$start_day -> setDate($date, DATE_FORMAT_ISO);

	$rowspan_count=0;
	$total_hours_daily=0;
	$total_hours_weekly=0;
	$dow=0;
	$last_day = new CDate();
	$last_day -> copy($start_day);
	$no_results = true;
	$first=1;

	for($dow=0;$dow<7;$dow++){
		writeDayLine($last_day,$df,$AppUI->_('Add Task Log'),$is_my_timesheet,$user_id,$newTLogTabNum);

		foreach ($result as $task) {
			$task_date = new CDate( $task["task_log_date"] );

			$task_dow = $task_date->getDayOfWeek();

			if($task_dow==$dow){
				$total_hours_daily += $task["task_log_hours"];

				?>
				<tr>
					<td nowrap="nowrap" valign="top">
					<?php if($task['task_id']){ ?>
						<a href="?m=tasks&a=view&task_id=<?php echo $task["task_id"]; ?>"><?php echo $task["task_name"]; ?></a>
					<?php } else if(isset($task['task_log_help_desk_id'])&&$task['task_log_help_desk_id']){ ?>
						<a href="?m=helpdesk&a=view&item_id=<?php echo $task["task_log_help_desk_id"];?>"><?php echo $task["task_name"]; ?></a>
					<?php } else { ?>
						<?php echo $task["task_log_name"]; ?>
					<?php } ?>
					</td>
					<td>
					<?php if($task['task_log_creator']==$AppUI->user_id || $can_edit_other_timesheets){ 
						if(!isset($task['task_log_help_desk_id']) || (isset($task['task_log_help_desk_id']) && !$task['task_log_help_desk_id']) || $integrate_with_helpdesk){
					?>
						<a href="?m=timecard&tab=<?php echo isset($task['task_log_help_desk_id']) && $task['task_log_help_desk_id'] ? 5 : $newTLogTabNum;?>&tid=<?php echo $task["task_log_id"]; ?>">[<?php echo $AppUI->_('Edit'); ?>]</a>
					<?php }
						} ?>
					<?php echo $task["task_log_description"]; ?></td>
					<td align="right" valign="top"><?php echo number_format($task["task_log_hours"],2); ?></td>
				</tr>
				<?php
			}
			
		}


		writeDayTotal($AppUI->_('Total Hours'),$last_day->isWorkingDay(),$total_hours_daily,$min_hours_day, $show_possible_hours_worked);
		$total_hours_weekly += $total_hours_daily;
		$total_hours_daily = 0;
		$last_day->addDays(1);
		$date = $last_day->format("%Y-%m-%d")." 12:00:00";
		$last_day -> setDate($date, DATE_FORMAT_ISO);

	}

	echo "<tr><th nowrap=\"nowrap\" valign=\"top\" colspan=\"4\" ><div align=\"left\"><b>".$AppUI->_('For the week of')." ".$start_day -> getDayName(false). " " .$start_day->format( $df )." ".$AppUI->_('through')." ".$end_day -> getDayName(false). " " .$end_day->format( $df )."</b></div></th></tr>";;
	echo "<tr><td colspan=\"2\" align=\"right\"><b>".$AppUI->_('Total Hours')."</b></td><td align=\"right\">";
	if ($show_possible_hours_worked && $total_hours_weekly<$min_hours_week) {
		echo "<b><span style=\"padding-left: 5px;padding-right:5px;border:2px solid red;background-color:#FFF2F2;\">".($min_hours_week-$total_hours_weekly)."</span></b>";
	}
	echo "<b><span  style=\"padding-left: 5px;padding-right:5px;border:2px solid #999999;\"> ".number_format($total_hours_weekly,1)."</span></b>";
	echo "</td></tr>";
	?>
	</table>
	</form>
<?php
function writeDayLine($day,$format,$task_string,$show_add,$userid,$newTLogTabNum)
{
	$day_name = $day->getDayName(false);
	echo "<tr><td nowrap=\"nowrap\" valign=\"top\" colspan=\"".($show_add?"2":"3")."\"  style=\"background-color:#D7EAFF;\">";
	echo "<div align=\"left\">";
	echo "<b>".$day_name."</b> ".$day->format( $format );
	echo "</div>";
	echo "</td>";
	if($show_add){
		echo "<td nowrap=\"nowrap\" align=\"center\"  style=\"background-color:#D7EAFF;\">";
		echo "<a href=\"?m=timecard&tab=".$newTLogTabNum."&userid=".$userid."&date=".urlencode($day->getDate())."\">[".$task_string."]</a>";
		echo "</td>";
	}
	echo "</tr>";
}

function writeDayTotal($total_string,$workday,$total_hours,$hours_per_day, $show_possible_hours_worked)
{
	echo "<tr><td colspan=\"2\" align=\"right\"><b>".$total_string."</b></td>";
	echo "<td align=\"right\" >";
	if($show_possible_hours_worked && $total_hours<$hours_per_day && $workday){
		echo "<b><span style=\"padding-left: 5px;padding-right:5px;border:2px solid red;background-color:#FFF2F2;\">".number_format($hours_per_day-$total_hours,1)."</span></b>";
	}
	echo "<b><span style=\"padding-left: 5px;padding-right:5px;border:2px solid #999999;\"> ".number_format($total_hours,1)."</span></b>";
	echo "</td></tr>";
}

?>