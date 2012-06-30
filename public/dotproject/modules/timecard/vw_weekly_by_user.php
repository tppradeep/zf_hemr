<?php /* HELPDESK $Id: vw_weekly_by_user.php,v 1.1 2007/08/22 07:47:47 arcoz67 Exp $ */
	global $tab,$TIMECARD_CONFIG;
	$show_possible_hours_worked = $TIMECARD_CONFIG['show_possible_hours_worked'];
	//print "<pre>$show_possible_hours_worked</pre>";
	//grab hours per day from config
	$min_hours_day = $dPconfig['daily_working_hours'];
	//compute hours/week from config
	$min_hours_week =count(explode(",",$dPconfig["cal_working_days"])) * $min_hours_day;
	// get date format
	$df = $AppUI->getPref('SHDATEFORMAT');
	
	//How many weeks are we going to show?
	$week_count = 4;
		
	if (isset( $_GET['start_date'] )) {
		$AppUI->setState( 'TimecardWeeklyReportStartDate', $_GET['start_date'] );
	}
	$start_day = new CDate( $AppUI->getState( 'TimecardWeeklyReportStartDate' ) ? $AppUI->getState( 'TimecardWeeklyReportStartDate' ) : NULL);

	if (isset( $_GET['company_id'] )) {
		$AppUI->setState( 'TimecardWeeklyReportCompanyId', $_GET['company_id'] );
	}
	$company_id = $AppUI->getState( 'TimecardWeeklyReportCompanyId' ) ? $AppUI->getState( 'TimecardWeeklyReportCompanyId' ) : 0;
  //print $company_id;
	//set that to just midnight so as to grab the whole day
	$date = $start_day->format("%Y-%m-%d")." 00:00:00";
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

	//set that to just before midnight so as to grab the whole day
	$date = $end_day->format("%Y-%m-%d")." 23:59:59";
	$end_day -> setDate($date, DATE_FORMAT_ISO);

	$selects = array();
	$join = array();
	
	$where = getPermsWhereClause("companies", "user_company");
	
	$sql = "
		SELECT 
			user_id,
			concat(contact_first_name,' ',contact_last_name) as name,
			contact_email,
			company_name
		FROM 
			dotp_users
			LEFT JOIN dotp_contacts ON dotp_users.user_contact=dotp_contacts.contact_id
			LEFT JOIN dotp_companies ON dotp_companies.company_id=dotp_contacts.contact_company
		WHERE 
		".$where."
	";

	if($company_id>0){
		$sql .= " AND dotp_contacts.contact_company = $company_id";
	}
	
	$sql .= " ORDER BY contact_first_name, contact_last_name";

	//print "<pre>$sql</pre>";
	$result = db_loadList($sql);


	for($i=0;$i<count($result);$i++){
		$people[$result[$i]['user_id']] = $result[$i];
		$ids[] = $result[$i]['user_id'];
	}
	unset($result);
	
	if(isset($ids))
	for($i=0;$i<$week_count;$i++){
		//set that to just midnight so as to grab the whole day
		$date = $start_day->format("%Y-%m-%d")." 00:00:00";
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

		//set that to just midnight so as to grab the whole day
		$date = $start_day->format("%Y-%m-%d")." 00:00:00";
		$start_day -> setDate($date, DATE_FORMAT_ISO);
		//set that to just before midnight so as to grab the whole day
		$date = $end_day->format("%Y-%m-%d")." 23:59:59";
		$end_day -> setDate($date, DATE_FORMAT_ISO);

		$start_month = $start_day->format("%b");
		$end_month = $end_day->format("%b");
		$start_date = $start_day->format("%e");
		$end_date = $end_day->format("%e");
	
		$start_data_pretty[$i] =  "$start_month $start_date-".($start_month==$end_month?$end_date:"$end_month $end_date");
		$start_data_linkable[$i] =  urlencode($start_day->getDate()) ;
//		$starts[$i] =  $start_day->format($df);
		$sql = "
			SELECT
				task_log_creator,
				sum(task_log_hours) as hours
			FROM
				dotp_task_log
			WHERE
				task_log_date >= '".$start_day->format( FMT_DATETIME_MYSQL )."' 
				AND task_log_date <= '".$end_day->format( FMT_DATETIME_MYSQL )."'
				AND task_log_creator in (".implode(", ",$ids).")
			GROUP BY
				task_log_creator
			";

		//print "<pre>$sql</pre>";
		$result = db_loadList($sql);

		foreach($result as $row){
			$people[$row['task_log_creator']][$i] = $row['hours'];
		}

		$date = $start_day->format("%Y-%m-%d")." 12:00:00";
		$start_day -> setDate($date, DATE_FORMAT_ISO);
		$start_day -> addDays(-7);
	}

	$sql = "SELECT company_id, company_name FROM dotp_companies WHERE ".getPermsWhereClause("companies", "company_id")." ORDER BY company_name";
		//print "<pre>$sql</pre>";
	$companies = arrayMerge( array( 0 => $AppUI->_('All Entities') ), db_loadHashList( $sql ) );

	$next_day = new CDate ();
	$next_day -> copy($start_day);
	$next_day -> addDays($week_count*7*2);
?>
<form name="frmCompanySelect" action="" method="get">
	<input type="hidden" name="m" value="timecard">
	<input type="hidden" name="report_type" value="weekly_by_user">
	<input type="hidden" name="tab" value="<?php echo $tab?>">
	<table cellspacing="1" cellpadding="2" border="0" width="100%">
	<tr>
		<td width="95%"><?php echo arraySelect( $companies, 'company_id', 'size="1" class="text" id="medium" onchange="document.frmCompanySelect.submit()"',
                          $company_id )?></td>
                <?php
                	$prev_url = "?m=timecard&tab=$tab&report_type=weekly_by_user&start_date=".urlencode($start_day->getDate());
                	$next_url = "?m=timecard&tab=$tab&report_type=weekly_by_user&start_date=".urlencode($next_day->getDate());
                ?>
		<td width="1%" nowrap="nowrap"><a href="<?php echo $prev_url?>"><img src="./images/prev.gif" width="16" height="16" alt="<?php echo $AppUI->_( 'previous' );?>" border="0"></a></td>
		<td width="1%" nowrap="nowrap"><a href="<?php echo $prev_url?>"><?php echo $AppUI->_('previous')?> <?php echo  $week_count?> <?php echo $AppUI->_('weeks')?></a></td>
		<td width="1%" nowrap="nowrap">&nbsp;|&nbsp;</td>
		<td width="1%" nowrap="nowrap"><a href="<?php echo $next_url?>"><?php echo $AppUI->_('next')?> <?php echo  $week_count?> <?php echo $AppUI->_('weeks')?></a></td>
		<td width="1%" nowrap="nowrap"><a href="<?php echo $next_url?>"><img src="./images/next.gif" width="16" height="16" alt="<?php echo $AppUI->_( 'next' );?>" border="0"></a></td>
	</tr>
	</table>

</form>
<table cellspacing="1" cellpadding="2" border="0" class="std" width="100%">
<?php
	if(!isset($people)){
?>
	<tr><td align="center"><?php echo $AppUI->_('No Users Available')?></td></tr>
<?php
	} else {

?>
<tr>
	<th><?php echo $AppUI->_('User')?></th>
	<th><?php echo $AppUI->_('Entity')?></th>
<?php
	if(isset($start_data_pretty))
	for($i=$week_count-1;$i>=0;$i--){
?>
	<th width="120px"><?php echo $start_data_pretty[$i]?></th>
<?php
	}
?>
</tr>
<?php
	if(isset($people))
	foreach($people as $id => $person){
?>
<tr>
	<td nowrap="nowrap"><?php echo $person['name']?></td>
	<td nowrap="nowrap"><?php echo $person['company_name']?></td>
<?php
	for($i=$week_count-1;$i>=0;$i--){
		 $hours = isset($person[$i])?$person[$i]:0;
		 $hours = round($hours,2);
		 if ($i==0 AND $hours == $person['user_id']) {
		   $hours = 0;
		 }
?>
	<td align="right"<?php echo $show_possible_hours_worked&&$hours>$min_hours_week?"bgcolor=\"#FFAEB8\"":""?>><a href="?m=timecard&user_id=<?php echo $id?>&tab=0&start_date=<?php echo $start_data_linkable[$i]?>"><?php echo number_format($hours,1)?></a></td>
<?php
	}
?>
</tr>
<?php
	}
}
?>
</table>
	
	
