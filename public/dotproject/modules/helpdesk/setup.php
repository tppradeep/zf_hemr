<?php /* HELPDESK $Id: setup.php,v 1.34 2004/05/05 20:04:04 bloaterpaste Exp $ */

/* Help Desk module definitions */
$config = array();
$config['mod_name'] = 'HelpDesk';
$config['mod_version'] = '0.2';
$config['mod_directory'] = 'helpdesk';
$config['mod_setup_class'] = 'CSetupHelpDesk';
$config['mod_type'] = 'user';
$config['mod_config'] = false;
$config['mod_ui_name'] = 'Help Desk';
$config['mod_ui_icon'] = 'helpdesk.png';
$config['mod_description'] = 'Help Desk is a bug, feature request, '
                           . 'complaint and suggestion tracking centre';

if (@$a == 'setup') {
	echo dPshowModuleConfig( $config );
}

require_once( $AppUI->cfg['root_dir'].'/modules/system/syskeys/syskeys.class.php');

class CSetupHelpDesk {
	function install() {
		$success = 1;
		$bulk_sql[] = "
			CREATE TABLE helpdesk_items (
			  `item_id` int(11) unsigned NOT NULL auto_increment,
			  `item_title` varchar(64) NOT NULL default '',
			  `item_summary` text,
			  `item_calltype` int(3) unsigned NOT NULL default '0',
			  `item_source` int(3) unsigned NOT NULL default '0',
			  `item_os` varchar(48) NOT NULL default '',
			  `item_application` varchar(48) NOT NULL default '',
			  `item_priority` int(3) unsigned NOT NULL default '0',
			  `item_severity` int(3) unsigned NOT NULL default '0',
			  `item_status` int(3) unsigned NOT NULL default '0',
			  `item_assigned_to` int(11) NOT NULL default '0',
			  `item_created_by` int(11) NOT NULL default '0',
			  `item_notify` int(1) DEFAULT '1' NOT NULL ,
			  `item_requestor` varchar(48) NOT NULL default '',
			  `item_requestor_id` int(11) NOT NULL default '0',
			  `item_requestor_email` varchar(128) NOT NULL default '',
			  `item_requestor_phone` varchar(30) NOT NULL default '',
			  `item_requestor_type` tinyint NOT NULL default '0',
			  `item_created` datetime default NULL,
			  `item_modified` datetime default NULL,
			  `item_parent` int(10) unsigned NOT NULL default '0',
			  `item_project_id` int(11) NOT NULL default '0',
			  `item_company_id` int(11) NOT NULL default '0',
			  PRIMARY KEY (item_id)
			) TYPE=MyISAM";

		$bulk_sql[] = "
      ALTER TABLE `task_log`
      ADD `task_log_help_desk_id` int(11) NOT NULL default '0' AFTER `task_log_task`
    ";

		$bulk_sql[] = "
		  CREATE TABLE `helpdesk_item_status` (
		    `status_id` INT NOT NULL AUTO_INCREMENT,
		    `status_item_id` INT NOT NULL,
		    `status_code` TINYINT NOT NULL,
		    `status_date` TIMESTAMP NOT NULL,
		    `status_modified_by` INT NOT NULL,
		    `status_comment` TEXT DEFAULT '',
		    PRIMARY KEY (`status_id`)
		  )";

    foreach ($bulk_sql as $s) {
      db_exec($s);

      if (db_error()) {
	$success = 0;
      }
    }

		$sk = new CSysKey( 'HelpDeskList', 'Enter values for list', '0', "\n", '|' );
		$sk->store();

		$sv = new CSysVal( $sk->syskey_id, 'HelpDeskPriority', "0|Not Specified\n1|Low\n2|Medium\n3|High" );
		$sv->store();

		$sv = new CSysVal( $sk->syskey_id, 'HelpDeskSeverity', "0|Not Specified\n1|No Impact\n2|Low\n3|Medium\n4|High\n5|Critical" );
		$sv->store();

		$sv = new CSysVal( $sk->syskey_id, 'HelpDeskCallType', "0|Not Specified\n1|Bug\n2|Feature Request\n3|Complaint\n4|Suggestion" );
		$sv->store();

		$sv = new CSysVal( $sk->syskey_id, 'HelpDeskSource', "0|Not Specified\n1|E-Mail\n2|Phone\n3|Fax\n4|In Person\n5|E-Lodged\n6|WWW" );
		$sv->store();

		$sv = new CSysVal( $sk->syskey_id, 'HelpDeskOS', "Not Applicable\nLinux\nUnix\nSolaris 8\nSolaris 9\nRed Hat 6\nRed Hat 7\nRed Hat 8\nWindows 95\nWindow 98\nWindows 2000\nWindow 2000 Server\nWindows XP" );
		$sv->store();

		$sv = new CSysVal( $sk->syskey_id, 'HelpDeskApplic', "Not Applicable\nWord\nExcel" );
		$sv->store();

		$sv = new CSysVal( $sk->syskey_id, 'HelpDeskStatus', "0|Unassigned\n1|Open\n2|Closed\n3|On Hold\n4|Testing" );
		$sv->store();

		$sv = new CSysVal( $sk->syskey_id, 'HelpDeskAuditTrail', "0|Created\n1|Title\n2|Requestor Name\n3|Requestor E-mail\n4|Requestor Phone\n5|Assigned To\n6|Notify by e-mail\n7|Company\n8|Project\n9|Call Type\n10|Call Source\n11|Status\n12|Priority\n13|Severity\n14|Operating System\n15|Application\n16|Summary\n17|Deleted" );
		$sv->store();
		
	        return $success;
	}

	function remove() {
		$success = 1;

		$bulk_sql[] = "DROP TABLE helpdesk_items";
		$bulk_sql[] = "DROP TABLE helpdesk_item_status";
		$bulk_sql[] = "ALTER TABLE `task_log` DROP COLUMN `task_log_help_desk_id`";

		foreach ($bulk_sql as $s) {
			db_exec($s);
			if (db_error())
				$success = 0;
		}

		$sql = "
			SELECT syskey_id
			FROM syskeys
			WHERE syskey_name = 'HelpDeskList'";
		$id = db_loadResult( $sql );

    		unset($bulk_sql);

		$bulk_sql[] = "DELETE FROM syskeys WHERE syskey_id = $id";
		$bulk_sql[] = "DELETE FROM sysvals WHERE sysval_key_id = $id";

		foreach ($bulk_sql as $s) {
			db_exec($s);
			if (db_error())
				$success = 0;
		}

		return $success;
	}

	function upgrade($old_version) {
		$success = 1;

	    switch ($old_version) {
	      case "0.1":
		$bulk_sql[] = "
		  ALTER TABLE `helpdesk_items`
		  ADD `item_requestor_phone` varchar(30) NOT NULL default '' AFTER `item_requestor_email`,
		  ADD `item_company_id` int(11) NOT NULL default '0' AFTER `item_project_id`,
		  ADD `item_requestor_type` tinyint NOT NULL default '0' AFTER `item_requestor_phone`,
		  ADD `item_notify` int(1) DEFAULT '1' NOT NULL AFTER `item_assigned_to`,
		  ADD `item_created_by` int(11) NOT NULL default '0',
		  DROP `item_receipt_target`,
		  DROP `item_receipt_custom`,
		  DROP `item_receipted`,
		  DROP `item_resolve_target`,
		  DROP `item_resolve_custom`,
		  DROP `item_resolved`,
		  DROP `item_assetno`
		";

		$bulk_sql[] = "
		  ALTER TABLE `task_log`
		  ADD `task_log_help_desk_id` int(11) NOT NULL default '0' AFTER `task_log_task`
		";

		$bulk_sql[] = "
		  CREATE TABLE `helpdesk_item_status` (
		    `status_id` INT NOT NULL AUTO_INCREMENT,
		    `status_item_id` INT NOT NULL,
		    `status_code` TINYINT NOT NULL,
		    `status_date` TIMESTAMP NOT NULL,
		    `status_modified_by` INT NOT NULL,
		    `status_comment` TEXT DEFAULT '',
		    PRIMARY KEY (`status_id`)
		  )
		";

		$sql = "SELECT syskey_id
			FROM syskeys
			WHERE syskey_name = 'HelpDeskList'";
		$syskey_id = db_loadResult( $sql );

		$sv = new CSysVal( $syskey_id, 'HelpDeskAuditTrail', "0|Created\n1|Title\n2|Requestor Name\n3|Requestor E-mail\n4|Requestor Phone\n5|Assigned To\n6|Notify by e-mail\n7|Company\n8|Project\n9|Call Type\n10|Call Source\n11|Status\n12|Priority\n13|Severity\n14|Operating System\n15|Application\n16|Summary\n17|Deleted" );
		$sv->store();


		$sql = "UPDATE sysvals
			SET sysval_value='0|Unassigned\n1|Open\n2|Closed\n3|On Hold\n4|Testing'
			WHERE sysval_title='HelpDeskStatus'
			LIMIT 1";

		db_exec($sql);
		break;
	      default:
		$success = 0;
	    }

		foreach ($bulk_sql as $s) {
			db_exec($s);
			if (db_error())
				$success = 0;
		}
  
		// NOTE: Need to return true, not null, if all is good
		return $success;
	}

  /* NOTE: Configuration handling in dotProject is iffy at best. We're working
     with what we have *shrugs* */
/*
  function configure() {
    global $AppUI;

    $AppUI->redirect("m=helpdesk&a=configure");

    return true;
  }
*/
}
?>
