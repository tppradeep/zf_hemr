<?php /* HELPDESK $Id: vw_weekly_by_project.php,v 1.1 2007/08/22 07:47:47 arcoz67 Exp $ */
	global $tab,$TIMECARD_CONFIG;
	
	$show_possible_hours_worked = $TIMECARD_CONFIG['show_possible_hours_worked'];

	// get date format
	$df = $AppUI->getPref('SHDATEFORMAT');

	//grab hours per day from config
//	$min_hours_day = $AppUI->cfg['daily_working_hours'];
	$min_hours_day = dPgetConfig("daily_working_hours");
	//compute hours/week from config
	$min_hours_week =count(explode(",",dPgetConfig("cal_working_days"))) * $min_hours_day;
	// get date format
	$df = $AppUI->getPref('SHDATEFORMAT');
	
	//How many weeks are we going to show?
	$week_count = 4;
		
	$report_department_types = array(
		'project' => $AppUI->_('Project Department'),
		'user' => $AppUI->_('User Department')
		);
	
	if (isset( $_GET['start_date'] )) {
		$AppUI->setState( 'TimecardWeeklyReportStartDate', $_GET['start_date'] );
	}
	$start_day = new CDate( $AppUI->getState( 'TimecardWeeklyReportStartDate' ) ? $AppUI->getState( 'TimecardWeeklyReportStartDate' ) : NULL);

	if (isset( $_GET['end_date'] )) {
		$AppUI->setState( 'TimecardWeeklyReportEndDate', $_GET['end_date'] );
	}
	$end_day = new CDate( $AppUI->getState( 'TimecardWeeklyReportEndDate' ) ? $AppUI->getState( 'TimecardWeeklyReportEndDate' ) : NULL);

	if (isset( $_GET['company_id'] )) {
		$AppUI->setState( 'TimecardWeeklyReportCompanyId', $_GET['company_id'] );
	}
	$company_id = $AppUI->getState( 'TimecardWeeklyReportCompanyId' ) ? $AppUI->getState( 'TimecardWeeklyReportCompanyId' ) : 0;

	if (isset( $_GET['user_id'] )) {
		$AppUI->setState( 'TimecardWeeklyReportPeopleId', $_GET['user_id'] );
	}
	$user_id = $AppUI->getState( 'TimecardWeeklyReportPeopleId' ) ? $AppUI->getState( 'TimecardWeeklyReportPeopleId' ) : 0;

	if (isset( $_GET['browse'] )) {
		$AppUI->setState( 'TimecardWeeklyReportBrowse', $_GET['browse'] );
	}
	$browse = $AppUI->getState( 'TimecardWeeklyReportBrowse')=='0'?false:true;

	if (isset( $_GET['report_department_type'] )) {
		$AppUI->setState( 'TimecardWeeklyReportDepartmentType', $_GET['report_department_type'] );
	}
	$report_department_type = $AppUI->getState( 'TimecardWeeklyReportDepartmentType')!=NULL?$AppUI->getState( 'TimecardWeeklyReportDepartmentType'):key($report_department_types);

	//set that to just midnight so as to grab the whole day
	$date = $start_day->format("%Y-%m-%d")." 00:00:00";
	$start_day -> setDate($date, DATE_FORMAT_ISO);
	
	if($browse){
		$today_weekday = $start_day -> getDayOfWeek();

		//roll back to the first day of that week, regardless of what day was specified
		$rollover_day = '0';
		$new_start_offset = $rollover_day - $today_weekday;
		$start_day -> addDays($new_start_offset);

		//last day of that week, add 6 days
		$end_day = new CDate ();
		$end_day -> copy($start_day);
		$end_day -> addDays(6);
	} else {
		$week_count = 1;
	}


	//set that to just before midnight so as to grab the whole day
	$date = $end_day->format("%Y-%m-%d")." 23:59:59";
	$end_day -> setDate($date, DATE_FORMAT_ISO);

	//Get hash of users
//Pedro A.
	$sql = "SELECT user_id, contact_email, concat(contact_first_name,' ',contact_last_name) as name FROM dotp_users LEFT JOIN dotp_contacts AS c ON dotp_users.user_contact = contact_id ORDER BY contact_first_name, contact_last_name;";
//End Pedro A.
	$result = db_loadList($sql);	
	$people = array();

	foreach($result as $row){
		$people[$row['user_id']] = $row;
		$users[$row['user_id']] = $row['name'];
	}
	unset($result);

	$users = arrayMerge( array( 0 => $AppUI->_('All Users') ), $users );


	//Get hash of departments
	$sql = "SELECT dept_id, dept_name FROM dotp_departments ORDER BY dept_name;";
	$result = db_loadList($sql);	
	$departments = array();
	foreach($result as $row){
		$departments[$row['dept_id']] = $row['dept_name'];
	}
	unset($result);

	$sql = "
		SELECT 
			project_id,
			project_name,
			company_name
		FROM 
			dotp_projects
			LEFT JOIN dotp_companies ON dotp_projects.project_company=dotp_companies.company_id
		WHERE 
		".getPermsWhereClause("companies", "company_id")."
	";
	if($company_id>0){
		$sql .= " AND dotp_projects.project_company = $company_id";
	}
	
	$sql .= " ORDER BY project_name";

//	print "<pre>$sql</pre>";
	$result = db_loadList($sql);


	for($i=0;$i<count($result);$i++){
		$project_id = $result[$i]['project_id'];
//		$projects[$project_id] = $result[$i];
//		$projects[$project_id]['totals'] = array();
//		$projects[$project_id]['users'] = array();
		$ids[] = $project_id;
		unset($project_id);
	}
	unset($result);
	
	if(isset($ids))
	for($i=0;$i<$week_count;$i++){
		//set that to just midnight so as to grab the whole day
		$date = $start_day->format("%Y-%m-%d")." 00:00:00";
		$start_day -> setDate($date, DATE_FORMAT_ISO);

		if($browse){
			$today_weekday = $start_day -> getDayOfWeek();
			//roll back to the first day of that week, regardless of what day was specified
			$rollover_day = '0';
			$new_start_offset = $rollover_day - $today_weekday;
			$start_day -> addDays($new_start_offset);

			//last day of that week, add 6 days
			$end_day = new CDate ();
			$end_day -> copy($start_day);
			$end_day -> addDays(6);
		}

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

    // 8:42 PM 2007-08-05 MatthewA : corrected query string to grab departments correctly
		$sql = '
			SELECT 
				task_log_creator,
				contact_department,
				dotp_projects.project_id, 
				project_name, 
				department_id,
				project_company,
				company_name,
				sum(task_log_hours) as hours
			FROM 
				dotp_task_log
				left join dotp_tasks on dotp_task_log.task_log_task = dotp_tasks.task_id
				left join dotp_projects on dotp_tasks.task_project = dotp_projects.project_id
				left join dotp_users on dotp_task_log.task_log_creator = dotp_users.user_id
				left join dotp_companies on dotp_projects.project_company = dotp_companies.company_id
				left join dotp_project_departments on dotp_projects.project_id = dotp_project_departments.project_id
				left join dotp_contacts on dotp_users.user_contact = dotp_contacts.contact_id
			WHERE
				dotp_projects.project_id in ('.implode(", ",$ids).")
				AND task_log_date >= '".$start_day->format( FMT_DATETIME_MYSQL )."' 
				AND task_log_date <= '".$end_day->format( FMT_DATETIME_MYSQL )."'"
				.($user_id>0?" AND task_log_creator = $user_id ":'').'
				GROUP BY
				project_company,dotp_projects.project_id,dotp_task_log.task_log_creator
		';

		if ($i == 0) {
		  //print "<pre>$sql</pre>";
		}
		$result = db_loadList($sql);
    // 8:42 PM 2007-08-05 MatthewA : corrected field names
		$department_field = $report_department_type=='project'?'department_id':'contact_department';
		//print "<pre>$department_field</pre>";

		foreach($result as $row){
			//pull the department numbers apart, and populate them with their names.
			if($row[$department_field]!=null && $row[$department_field]!=0 && strlen($row[$department_field])>0){
				$department_list = explode(',',$row[$department_field]);
				for($c=0;$c<count($department_list);$c++){
					if(isset($departments[$department_list[$c]])){
						$department_list[$c] = $departments[$department_list[$c]];
					}
				}
			//} elseif ($row[$department_field]==0){
			//	$department_list = array($AppUI->_('Foreign Departments'));
			} else {
				$department_list = array($AppUI->_('Other/No Department'));
			}
			foreach($department_list as $department){
				if(!isset($projects[$row['company_name']]['departments'][$department]['projects'][$row['project_id']]['project_name'])){
					$projects[$row['company_name']]['departments'][$department]['projects'][$row['project_id']] = array(
						'project_name' => $row['project_name']
					);
				}
				$projects[$row['company_name']]['departments'][$department]['projects'][$row['project_id']]['users'][$row['task_log_creator']][$i] = $row['hours']/count($department_list);
				
				@$projects[$row['company_name']]['departments'][$department]['projects'][$row['project_id']]['totals'][$i] += $row['hours']/count($department_list);
				@$projects[$row['company_name']]['departments'][$department]['totals'][$i] += $row['hours']/count($department_list);
				@$projects[$row['company_name']]['totals'][$i] += $row['hours']/count($department_list);
			}
		}
		unset($result);
//print "<pre>".print_r($projects, true)."</pre><hr>";

		if($browse)
			$start_day -> addDays(-7);
	}

	$sql = "SELECT company_id, company_name FROM dotp_companies WHERE ".getPermsWhereClause("companies", "company_id")." ORDER BY company_name";
	$companies = arrayMerge( array( 0 => $AppUI->_('All Companies') ), db_loadHashList( $sql ) );

	//last day of that week, add 6 days
	$next_day = new CDate ();
	$next_day -> copy($start_day);
	$next_day -> addDays($week_count*7*2);
?>
<script language="javascript">
var calendarField = '';

function popCalendar( field ){
	calendarField = field;
	idate = eval( 'document.frmSelect.' + field + '_date.value' );
	window.open( 'index.php?m=public&a=calendar&dialog=1&callback=setCalendar&date=' + idate, 'calwin', 'top=250,left=250,width=250, height=220, scollbars=false' );
}

/**
 *	@param string Input date in the format YYYYMMDD
 *	@param string Formatted date
 */
function setCalendar( idate, fdate ) {
	fld_date = eval( 'document.frmSelect.' + calendarField + '_date' );
	fld_fdate = eval( 'document.frmSelect.' + calendarField );
	fld_date.value = idate;
	fld_fdate.value = fdate;
}
</script>
<form name="frmSelect" action="" method="get">
	<input type="hidden" name="m" value="timecard">
	<input type="hidden" name="report_type" value="weekly_by_project">
	<input type="hidden" name="tab" value="<?php echo $tab; ?>">
	<table cellspacing="1" cellpadding="2" border="0" width="100%">
	<tr>
		<td width="1%" valign="top" nowrap="nowrap"><?php echo arraySelect( $companies, 'company_id', 'size="1" class="text" id="medium" onchange="document.frmSelect.submit()"',
                          $company_id )?><?php echo arraySelect( $users, 'user_id', 'size="1" class="text" id="medium" onchange="document.frmSelect.submit()"',
                          $user_id )?></td>
		<td width="98%" align="right" valign="top">
			<table cellpadding="0" cellspacing="0" width="1%">
				<tr>
					<?php
						$prev_url = "?m=timecard&tab=$tab&report_type=weekly_by_project&start_date=".urlencode($start_day->getDate())."&browse=1";
						$next_url = "?m=timecard&tab=$tab&report_type=weekly_by_project&start_date=".urlencode($next_day->getDate())."&browse=1";
					?>
					<td width="95%">&nbsp;</td>
					<td width="1%"><a href="<?php echo $prev_url?>"><img src="./images/prev.gif" width="16" height="16" alt="<?php echo $AppUI->_( 'previous' );?>" border="0"></a></td>
					<td width="1%" nowrap="nowrap" style="padding-left:5px"><a href="<?php echo $prev_url?>"><?php echo $AppUI->_('previous')?> <?php echo  $week_count?> <?php echo $AppUI->_('weeks')?></a></td>
					<td width="1%">&nbsp;|&nbsp;</td>
					<td width="1%" nowrap="nowrap" style="padding-right:5px"><a href="<?php echo $next_url?>"><?php echo $AppUI->_('next')?> <?php echo  $week_count?> <?php echo $AppUI->_('weeks')?></a></td>
					<td width="1%"><a href="<?php echo $next_url?>"><img src="./images/next.gif" width="16" height="16" alt="<?php echo $AppUI->_( 'next' );?>" border="0"></a></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td width="98%" valign="top" colspan="2">
			
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="97%"><?php echo arraySelect($report_department_types, 'report_department_type',  'size="1" class="text" id="medium" onchange="document.frmSelect.submit()"', $report_department_type)?></td>
					<td nowrap="nowrap" width="1%">
						<input type="hidden" name="browse" value="0" />
						<input type="hidden" name="start_date" value="<?php echo $start_day->format( FMT_TIMESTAMP_DATE );?>" />
						<input type="text" name="start" value="<?php echo $start_day->format( $df );?>" class="text" disabled="disabled" />
						<a href="#" onClick="popCalendar('start')">
							<img src="./images/calendar.gif" width="24" height="12" alt="<?php echo $AppUI->_('Calendar');?>" border="0" />
						</a>
					</td>
					<td nowrap="nowrap" width="1%">
						<input type="hidden" name="end_date" value="<?php echo $end_day ? $end_day->format( FMT_TIMESTAMP_DATE ) : '';?>" />
						<input type="text" name="end" value="<?php echo $end_day ? $end_day->format( $df ) : '';?>" class="text" disabled="disabled" />
						<a href="#" onClick="popCalendar('end')">
							<img src="./images/calendar.gif" width="24" height="12" alt="<?php echo $AppUI->_('Calendar');?>" border="0" />
						</a>
					</td>
					<td width="1%">
						<input type="submit" value="<?php echo $AppUI->_('Report on Date Range')?>">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</table>

</form>
<table cellspacing="1" cellpadding="2" border="0" class="std" width="100%">
<tr>
	<th><?php echo $AppUI->_('Project/UserName')?></th>
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
	if(!isset($projects)){
?>
	<tr><td align="center" colspan="<?php echo ($week_count+1)?>"><?php echo $AppUI->_('No Data Available')?></td></tr>
<?php
	} else {
		$image_straight = '<img src="./modules/timecard/images/verticle-dots.png" width="16" height="12" border="0">';
		$image_elbow= '<img src="./images/corner-dots.gif" width="16" height="12" border="0">';
		$image_shim= '<img src="./images/shim.gif" width="16" height="12" border="0">';

?>
<?php
	if(isset($projects))
	foreach($projects as $id => $company){
		if(!next($projects)){
			$last_company=true;
		} else {
			$last_company=false;
		}
?>
<tr>
	<td style="background:#8AC6FF;"><?php echo $id?></td>
<?php
	for($i=$week_count-1;$i>=0;$i--){
?>
	<td style="background:#8AC6FF;" align="right"><?php echo isset($company['totals'][$i])?number_format(round($company['totals'][$i],2),2):"0.00"?></td>
<?php
	}
?>
</tr>
<?php

	foreach($company['departments'] as $id => $department){
		if(!next($company['departments'])){
			$last_department=true;
		} else {
			$last_department=false;
		}
?>
<tr>
	<td style="background:#A7D4FF;"><?php echo $image_elbow?><?php echo $id?></td>
<?php
	for($i=$week_count-1;$i>=0;$i--){
?>
	<td style="background:#A7D4FF;" align="right"><?php echo isset($department['totals'][$i])?number_format(round($department['totals'][$i],2),2):"0.00"?></td>
<?php
	}
?>
</tr>
<?php

	foreach($department['projects'] as $id => $project){
		if(!next($department['projects'])){
			$last_project=true;
		} else {
			$last_project=false;
		}

	//only display projects with time assigned

	if(isset($project['totals'])){
?>
<tr>
	<td nowrap="nowrap" style="background:#C0E0FF;"><?php echo !$last_department?$image_straight:$image_shim?><?php echo $image_elbow?><a href="?m=projects&a=view&project_id=<?php echo $id?>"><?php echo $project['project_name']?></a></td>
<?php
	for($i=$week_count-1;$i>=0;$i--){
?>
	<td align="right" style="background:#C0E0FF;"><?php echo isset($project['totals'][$i])?number_format(round($project['totals'][$i],2),2):"0.00"?></td>
<?php
	}
?>
</tr>
<?php
		if(isset($project['users']))
		foreach($project['users'] as $id => $person){
?>
<tr>
	<td><?php echo !$last_department?$image_straight:$image_shim?><?php echo !$last_project?$image_straight:$image_shim?><?php echo $image_elbow?><?php echo isset($people[$id]['name'])?$people[$id]['name']:$id?></td>
<?php
			for($i=$week_count-1;$i>=0;$i--){
				 $hours = isset($person[$i])?$person[$i]:0;
				 $hours = round($hours,2);
?>
	<td align="right"><a href="?m=timecard&user_id=<?php echo $id?>&tab=0&start_date=<?php echo $start_data_linkable[$i]?>"><?php echo number_format($hours,2)?></a></td>
<?php
			}
?>
</tr>
<?php
		}
?>
</tr>
<?php
	}
	}
	}
	}
}
?>
</table>
	
	
