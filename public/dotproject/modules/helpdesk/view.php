<?php /* HELPDESK $Id: view.php,v 1.49 2004/05/06 19:15:27 agorski Exp $ */

$item_id = dPgetParam( $_GET, 'item_id', 0 );

// check permissions for this record
$canReadModule = !getDenyRead( $m );

if (!$canReadModule) {
	$AppUI->redirect( "m=public&a=access_denied" );
}

$AppUI->savePlace();

// retrieve any state parameters
if (isset( $_GET['tab'] )) {
	$AppUI->setState( 'HelpLogVwTab', $_GET['tab'] );
}
$tab = $AppUI->getState( 'HelpLogVwTab' ) !== NULL ? $AppUI->getState( 'HelpLogVwTab' ) : 0;

// Pull data
$sql = "SELECT hi.*,
        CONCAT(u.user_first_name,' ',u.user_last_name) assigned_to_fullname,
        u.user_email as assigned_email,
        p.project_id,
        p.project_name,
        p.project_color_identifier,
        c.company_name
        FROM helpdesk_items hi
        LEFT JOIN users u ON u.user_id = hi.item_assigned_to
        LEFT JOIN projects p ON p.project_id = hi.item_project_id
        LEFT JOIN companies c ON c.company_id = hi.item_company_id
        WHERE item_id = '$item_id'";

if (!db_loadHash( $sql, $hditem )) {
	$titleBlock = new CTitleBlock( 'Invalid Helpdesk ID', 'helpdesk.png', $m, 'ID_HELP_HELPDESK_VIEW' );
	$titleBlock->addCrumb( "?m=helpdesk", "Home" );
	$titleBlock->addCrumb( "?m=helpdesk&a=list", "List" );
	$titleBlock->show();
} else {
  $sql = "SELECT *,
          TRIM(CONCAT(u.user_first_name,' ',u.user_last_name)) modified_by,
          u.user_email as email
          FROM helpdesk_item_status h
          LEFT OUTER JOIN users u ON u.user_id = h.status_modified_by
          WHERE h.status_item_id='{$hditem['item_id']}'
          ORDER BY h.status_date";

  $status_log = db_loadList($sql);
  
  // check permissions for this record
  $canRead = 0;
  $canEdit = 0;

  //Check to make sure that either this user created this record, or it belongs to that user company TODO:or it's a public item.
  $canReadCompany = !getDenyRead( "companies", $hditem['item_company_id'] );
  if($canReadCompany || $hditem['item_created_by']==$AppUI->user_id){
  	$canRead = 1;
  }

  //Check to make sure that either this user created this record, or it belongs to that user company TODO:or it's a public item.
  $canEditCompany = !getDenyEdit( "companies", $hditem['item_company_id'] );
  if($canEditCompany || $hditem['item_created_by']==$AppUI->user_id || !$item_id){
  	$canEdit = 1;
  }
  
  if(!$canRead && !$canEdit){
	$AppUI->redirect( "m=public&a=access_denied" );
  }
  

  $name = $hditem['item_requestor'];
  $assigned_to_name = $hditem["item_assigned_to"] ? $hditem["assigned_to_fullname"] : "";
  $assigned_email = $hditem["assigned_email"];

	// User's specified format for date and time
	$df = $AppUI->getPref('SHDATEFORMAT');
	$tf = $AppUI->getPref('TIMEFORMAT');
	$format = "$df $tf";
  $tc = $tm = $tr = "";

	if(@$hditem["item_created"]){
		$created = new CDate( @$hditem["item_created"] );
		$tc = $created->format( $format );
	}

	$titleBlock = new CTitleBlock( "Viewing Help Desk Item #{$hditem["item_id"]}", 'helpdesk.png',
                                 $m, 'ID_HELP_HELPDESK_IDX' );
	$titleBlock->addCrumb( "?m=helpdesk", "Home" );
	$titleBlock->addCrumb( "?m=helpdesk&a=list", "List" );

	if ($canEdit) {
    		$titleBlock->addCrumbDelete("Delete this item", 1);
		$titleBlock->addCell(
			'<input type="submit" class="button" value="'.$AppUI->_('New Item').'">', '',
			'<form action="?m=helpdesk&a=addedit" method="post">', '</form>'
		);
		$titleBlock->addCrumb( "?m=helpdesk&a=addedit&item_id=$item_id", "Edit this item" );
	}
	$titleBlock->show();
?>
<script language="JavaScript">
function delIt() {
  if (confirm( "<?php print $AppUI->_('doDelete').' '.$AppUI->_('item').'?';?>" )) {
    document.frmDelete.submit();
  }
}

function toggle_comment(id){
   var element = document.getElementById(id)
   element.style.display = (element.style.display == '' || element.style.display == "none") ? "inline" : "none"
}
</script>

<table border="0" cellpadding="4" cellspacing="0" width="100%">
<tr><td width="60%" valign="top">
<table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td valign="top">
<table border="0" cellpadding="4" cellspacing="0" width="100%" class="std">
<tr>
	<td valign="top" width="50%">
		<strong><?=$AppUI->_('Details')?></strong>
		<table cellspacing="1" cellpadding="2" width="100%">
		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Item Number')?>:</td>
			<td class="hilite" width="100%"><?=$hditem["item_id"]?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Title')?>:</td>
			<td class="hilite" width="100%"><?=$hditem["item_title"]?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Requestor')?>:</td>
			<td class="hilite" width="100%"><?php
        print $hditem["item_requestor_email"] ? 
          "<a href=\"mailto:".$hditem["item_requestor_email"]."\">".$hditem['item_requestor']."</a>" :
          $hditem['item_requestor'];?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Requestor Phone')?>:</td>
			<td class="hilite" width="100%"><?=$hditem["item_requestor_phone"]?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Assigned To')?>:</td>
			<td class="hilite" width="100%"><?php
        print $assigned_email ?
          "<a href=\"mailto:$assigned_email\">$assigned_to_name</a>" :
          $assigned_to_name;?></td>
		</tr>

    <tr>
      <td align="right" nowrap="nowrap"><?=$AppUI->_('Company')?>:</td>
			<td class="hilite" width="100%"><?=$hditem["company_name"]?></td>
    </tr>

    <tr>
      <td align="right" nowrap="nowrap"><?=$AppUI->_('Project')?>:</td>
      <td class="hilite" width="100%" style="background-color: #<?=$hditem['project_color_identifier']?>;"><a href="./index.php?m=projects&a=view&project_id=<?=$hditem["project_id"]?>"><?=$hditem["project_name"]?></a></td>
    </tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Call Type')?>:</td>
			<td class="hilite" width="100%"><?php
        print $ict[$hditem["item_calltype"]]." ";
        print dPshowImage (dPfindImage( 'ct'.$hditem["item_calltype"].'.png', $m ), 15, 17, 'align=center');
      ?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Call Source')?>:</td>
			<td class="hilite" width="100%"><?=@$ics[$hditem["item_source"]]?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Status')?>:</td>
			<td class="hilite" width="100%"><?=@$ist[$hditem["item_status"]]?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Priority')?>:</td>
			<td class="hilite" width="100%"><?=@$ipr[$hditem["item_priority"]]?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Severity')?>:</td>
      <td class="hilite" width="100%"><?=@$isv[$hditem["item_severity"]]?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Operating System')?>:</td>
			<td class="hilite" width="100%"><?=@$ios[$hditem["item_os"]]?></td>
		</tr>

		<tr>
			<td align="right" nowrap="nowrap"><?=$AppUI->_('Application')?>:</td>
			<td class="hilite" width="100%"><?=@$iap[$hditem["item_application"]]?></td>
		</tr>
		</table>
		<strong><?=$AppUI->_('Summary')?></strong>
		<table cellspacing="0" cellpadding="2" border="0" width="100%">
		<tr>
			<td class="hilite"><?=str_replace( chr(10), "<br />", $hditem["item_summary"])?>&nbsp;</td>
		</tr>
		</table>

	</td>
</tr>
<tr>
	<td valign="top" colspan="2">
	</td>
</tr>
</table>
</td></tr>
<tr><td valign="top">
<?php 

$tabBox = new CTabBox( "?m=helpdesk&a=view&item_id=$item_id", "", $tab );
//if ( $obj->task_dynamic == 0 ) {
	// tabbed information boxes
$tabBox->add( "{$AppUI->cfg['root_dir']}/modules/helpdesk/vw_logs", 'Task Logs' );
	// fixed bug that dP automatically jumped to access denied if user does not
	// have read-write permissions on task_id and this tab is opened by default (session_vars)
	// only if user has r-w perms on this task, new or edit log is beign showed
//	if (!getDenyEdit( $m, $task_id )) {
$tabBox->add( "{$AppUI->cfg['root_dir']}/modules/helpdesk/vw_log_update", 'New Log' );
//	}
//}
$tabBox->show();
} 
?>
</td></tr></table>

</td>
<td width="40%" valign="top">
<table border="0" cellpadding="4" cellspacing="0" width="100%" class="std">
<tr><td>
		<strong><?=$AppUI->_('Status Log')?></strong>
		<table cellspacing="1" cellpadding="2" border="0" width="100%" bgcolor="black">
    <?php
    $last_date = "";
    foreach ($status_log as $log) {
		  $log_date = new CDate($log['status_date']);
		  $date = $log_date->format( $df );
		  if($date!=$last_date){
		  	$last_date = $date;
		  ?>
      <tr>
        <th nowrap="nowrap" colspan="3"><?=$date?>:</th>
      </tr>
		  <?php
		  }
		
		  $time = $log_date->format( $tf );
      ?>
      <tr>
        <td class="hilite" nowrap="nowrap" width="1%"><?=$time?></td>
        <td class="hilite" nowrap="nowrap" width="1%"><?=($log['email']?"<a href=\"mailto: {$log['email']}\">{$log['modified_by']}</a>":$log['modified_by'])?></td>
        <td class="hilite" width="98%"><?php
        	if($log['status_code']==0 || $log['status_code']==17){
            // Created or Deleted
        		print $isa[$log['status_code']];
          } else if ($log['status_code'] == 16) {
            // Comment
            print "<a href=\"javascript:void(0);\"
                      onClick=\"toggle_comment('{$log['status_id']}_short');
                                toggle_comment('{$log['status_id']}_long');\">"
                . dPshowImage (dPfindImage( 'toggle.png', $m ), 16, 16, '')
                . "</a>";

            print "<span style='display: inline' id='{$log['status_id']}_short'> "
                . "{$isa[$log['status_code']]} "
                . htmlspecialchars(substr($log['status_comment'],0,8))
                . "</span><span style='display: none' id='{$log['status_id']}_long'> "
                . "{$isa[$log['status_code']]} "
                . htmlspecialchars($log['status_comment'])
                . "</span>";
        	} else {
            // Everything else
        		print $isa[$log['status_code']]." ".$log['status_comment'];
        	}
        ?></td>
      </tr>
      <?php
    }
    ?>
		</table>
</td></tr></table>
</td></tr></table>
<form name="frmDelete" action="./index.php?m=helpdesk&a=list" method="post">
  <input type="hidden" name="dosql" value="do_item_aed">
  <input type="hidden" name="del" value="1" />
  <input type="hidden" name="item_id" value="<?=$item_id?>" />
</form>
