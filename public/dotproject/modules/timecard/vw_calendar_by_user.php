<?php /* HELPDESK $Id: vw_calendar_by_user.php,v 1.3 2007/08/22 07:17:43 arcoz67 Exp $ */
/**
* Modified and adapted by Jonathan Dumaresq on 2005/03/08
* Modified by Matthew Arciniega on 2007/08/03
* Generates a report of the task logs for given dates for the logged user
*/
//print $tab;
error_reporting(E_ALL ^ E_NOTICE);
$do_report = dPgetParam( $_POST, "do_report", 1 );
$log_pdf = dPgetParam( $_POST, 'log_pdf', 0 );
$log_start_date = dPgetParam( $_POST, "log_start_date", 0 );
$log_end_date = dPgetParam( $_POST, "log_end_date", 0 );
// create Date objects from the datetime fields
$start_date = intval( $log_start_date ) ? new CDate( $log_start_date ) : new CDate();
$end_date = intval( $log_end_date ) ? new CDate( $log_end_date ) : new CDate();

$df = $AppUI->getPref('SHDATEFORMAT');
if (isset( $_GET['user_id'] )) {
	$sql = "SELECT user_contact FROM dotp_users WHERE user_id = ".$_GET['user_id'] ;
  $user_contact = db_loadresult( $sql );
	$sql = "SELECT contact_company FROM dotp_contacts WHERE contact_id = ".$user_contact ;
	//print "<pre>$sql</pre>";

	$company_id = db_loadResult( $sql );
	if(getDenyRead( "companies", $company_id )){
		$AppUI->redirect( "m=public&a=access_denied" );
	}
	$AppUI->setState( 'TimecardSelectedUser', $_GET['user_id'] );
}
$user_id = $AppUI->getState( 'TimecardSelectedUser' ) ? $AppUI->getState( 'TimecardSelectedUser' ) : $AppUI->user_id;

$AppUI->savePlace();



if (!$log_start_date) {
	$start_date->subtractSpan( new Date_Span( "14,0,0,0" ) );
}
$end_date->setTime( 23, 59, 59 );

?>
<script language="javascript" type="text/javascript">
<!--
var calendarField = '';

function popCalendar( field ){
	calendarField = field;
	idate = eval( 'document.editFrm.log_' + field + '.value' );
	window.open( 'index.php?m=public&a=calendar&dialog=1&callback=setCalendar&date=' + idate, 'calwin', 'top=250,left=250,width=250, height=220, scollbars=false' );
}

/**
 *	@param string Input date in the format YYYYMMDD
 *	@param string Formatted date
 */
function setCalendar( idate, fdate ) {
	fld_date = eval( 'document.editFrm.log_' + calendarField );
	fld_fdate = eval( 'document.editFrm.' + calendarField );
	fld_date.value = idate;
	fld_fdate.value = fdate;
}
// -->
</script>

<table cellspacing="0" cellpadding="4" border="0" width="100%" class="std">

<form name="editFrm" action="index.php?m=timecard" method="post">

<tr>
	<td align="right" nowrap="nowrap"><?php echo $AppUI->_('For period');?>:</td>
	<td nowrap="nowrap">
		<input type="hidden" name="log_start_date" value="<?php echo $start_date->format( FMT_TIMESTAMP_DATE );?>" />
		<input type="text" name="start_date" value="<?php echo $end_date->format( $df );?>" class="text" disabled="disabled" style="width: 80px" />
		<a href="#" onClick="popCalendar('start_date')">
			<img src="./images/calendar.gif" width="24" height="12" alt="<?php echo $AppUI->_('Calendar');?>" border="0" />
		</a>
	</td>
	<td align="right" nowrap="nowrap"><?php echo $AppUI->_('to');?></td>
	<td nowrap="nowrap">
		<input type="hidden" name="log_end_date" value="<?php echo $end_date ? $end_date->format( FMT_TIMESTAMP_DATE ) : '';?>" />
		<input type="text" name="end_date" value="<?php echo $end_date ? $end_date->format( $df ) : '';?>" class="text" disabled="disabled" style="width: 80px"/>
		<a href="#" onClick="popCalendar('end_date')">
			<img src="./images/calendar.gif" width="24" height="12" alt="<?php echo $AppUI->_('Calendar');?>" border="0" />
		</a>
	</td>
	
	<td nowrap="nowrap">
		<input type="checkbox" name="log_pdf" <?php if ($log_pdf) echo "checked" ?> />
		<?php echo $AppUI->_( 'Make PDF' );?>
	</td>

	<td align="right" width="50%" nowrap="nowrap">
		<input class="button" type="submit" name="do_report" value="<?php echo $AppUI->_('submit');?>" />
	</td>
</tr>
</form>
</table>
<?php
if ($do_report) {

	$sql = "SELECT dotp_task_log.*, dotp_tasks.task_id,dotp_tasks.task_name, dotp_projects.project_name
		FROM
			dotp_task_log, dotp_tasks, dotp_projects
		WHERE
			dotp_task_log.task_log_task = dotp_tasks.task_id AND
			dotp_task_log.task_log_creator =".$user_id." AND
			dotp_tasks.task_project = dotp_projects.project_id AND
			dotp_task_log.task_log_date >=
			'".$start_date->format( FMT_DATETIME_MYSQL )."' AND
			dotp_task_log.task_log_date <= '".$end_date->format(FMT_DATETIME_MYSQL )."'
		ORDER BY task_log_date";
	//print "<pre>$sql</pre>";

	$logs = db_loadList( $sql );
	echo db_error();
?>
	<table width=100% cellspacing="1" cellpadding="4" border="0" class="tbl">
	<tr>
		<th width="10%" nowrap="nowrap">
		<?php echo $AppUI->_('Date');?></th>
		<th width="7%"><?php echo $AppUI->_('Project');?></th>
		<th width="21%"><?php echo $AppUI->_('Task & Log Title');?></th>
		<th width="60%"><?php echo $AppUI->_('Description');?></th>
		<th width="2%"><?php echo $AppUI->_('Hours');?></th>
	</tr>
	
<?php

	$pdfdata = array();
	$pdfdata[] = array(
		$AppUI->_('Date'),
		$AppUI->_('Project'),
		$AppUI->_('Task & Log Title'),
		$AppUI->_('Description'),
		$AppUI->_('Hours')
	);
	$total_hours = 0;
	foreach ($logs as $log) {
		$date = new CDate( $log['task_log_date'] );
		$total_hours += $log["task_log_hours"];
		$project_name = $log["project_name"];
		$pdfdata[] = array(
			$date->format( $df ),
			$log['project_name'],
			$log['task_name'],
		  $log['task_log_name'],
			$log['task_log_description'],
			sprintf( "%.2f", $log['task_log_hours'] )
		);
		
		if ($log['task_name'] == $log['task_log_name']) {
		  $taskTitle = $log['task_name'];
		} else {
		  $taskTitle = $log['task_name'].": ".$log['task_log_name'];
    }
			?>
			<tr>
				<td nowrap="nowrap" valign="top">
				<?php echo $date->format( $df );?>
				</td>
				<td nowrap="nowrap" valign="top">
				<?php echo $log['project_name'];?>
				</td>
				<td valign="top">
				<?php echo $taskTitle;?>
				</td>
				<td valign="top">
				<?php echo $log['task_log_description'];?>
				</td>
				<td nowrap="nowrap" valign="top">
				<?php echo sprintf( "%.2f", $log['task_log_hours']);?>
				</td>
			</tr>
		<?php
		}
		


	$pdfdata[] = array(
		'',
		'',
		'',
		$AppUI->_('Total Hours').':',
		sprintf( "%.2f", $total_hours ),
		'',
	);
	
?>
	<tr>
		<td align="right" colspan="4"><?php echo $AppUI->_('Total Hours');?>:</td>
		<td align="right"><?php printf( "%.2f", $total_hours );?></td>
	</tr>
	</table>
<?php
	if ($log_pdf) {
	// make the PDF file
		$sql = "SELECT user_contact FROM dotp_users WHERE user_id = ".$user_id ;
    $user_contact = db_loadresult( $sql );
	  $sql = "SELECT dotp_contacts.contact_first_name FROM dotp_contacts WHERE contact_id = ".$user_contact ;
    $firstName = db_loadresult( $sql );
	  $sql = "SELECT dotp_contacts.contact_last_name FROM dotp_contacts WHERE contact_id = ".$user_contact ;
    $lastName = db_loadresult( $sql );
		$pname = "For user: ".$firstName." ".$lastName;

		$font_dir = $dPconfig['root_dir']."/lib/ezpdf/fonts";
		$temp_dir = $dPconfig['root_dir']."/files/temp";
		$base_url  = $dPconfig['base_url'];
		require( $AppUI->getLibraryClass( 'ezpdf/class.ezpdf' ) );

		$pdf =& new Cezpdf();
		$pdf->ezSetCmMargins( 1, 1.5, 1.0, 1.0 );
		$pdf->selectFont( "$font_dir/Helvetica.afm" );

		$pdf->ezText( $dPconfig['company_name'], 12 );

		$date = new CDate();
		$pdf->ezText( "\n" . $date->format( $df ) , 8 );

		$pdf->selectFont( "$font_dir/Helvetica-Bold.afm" );
		$pdf->ezText( "\n" . $AppUI->_('Task Log Report'), 12 );
		$pdf->ezText( "$pname", 15 );
		$pdf->ezText( "Task log entries from ".$start_date->format( $df ).' to '.$end_date->format( $df ), 9 );
		$pdf->ezText( "\n\n" );

		$columns = null;
		$title = null;
		$options = array(
			'showLines' => 1,
			'showHeadings' => 0,
			'fontSize' => 7,
			'rowGap' => 2,
			'colGap' => 5,
			'xPos' => 50,
			'xOrientation' => 'right',
			'width'=>'500'
		);

		$pdf->ezTable( $pdfdata, $columns, $title, $options );

		if ($fp = fopen( "$temp_dir/temp$AppUI->user_id.pdf", 'wb' )) {
			fwrite( $fp, $pdf->ezOutput() );
			fclose( $fp );
			echo "<a href=\"$base_url/files/temp/temp$AppUI->user_id.pdf\" target=\"pdf\">";
			echo $AppUI->_( "View PDF File" );
			echo "</a>";
		} else {
			echo "Could not open file to save PDF.  ";
			if (!is_writable( $temp_dir )) {
				"The files/temp directory is not writable.  Check your file system permissions.";
			}
		}
	}
}

?>