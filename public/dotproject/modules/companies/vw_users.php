<?php /* COMPANIES $Id: vw_users.php 6048 2010-10-06 10:01:39Z ajdonnison $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

##
##	Companies: View User sub-table
##

GLOBAL $AppUI, $company_id;

$q  = new DBQuery;
$q->addTable('users', "usr");
$q->addQuery('user_id, user_username, contact_first_name, contact_last_name');
$q->addJoin('contacts', 'c', 'usr.user_contact = contact_id');
$q->addWhere('contact_company = '.$company_id);
$q->addOrder('contact_last_name');

if (!($rows = $q->loadList())) {
	echo $AppUI->_('No data available').'<br />'.$AppUI->getMsg();
} else {
?>
<table width="100%" border="0" cellpadding="2" cellspacing="1" class="tbl">
<tr>
	<th><?php echo $AppUI->_('Username');?></th>
	<th><?php echo $AppUI->_('Name');?></th>
</tr>
<?php
$s = '';
foreach ($rows as $row) {
	$s .= '<tr><td>';
	$s .= ('<a href="./index.php?m=admin&amp;a=viewuser&amp;user_id=' . $row['user_id'] . '">' 
	       . htmlspecialchars($row['user_username']) . '</a>');
	$s .= ('<td>' . htmlspecialchars($row['contact_last_name'] . ', ' . $row['contact_first_name']) 
	       . '</td>'); 
	$s .= "</tr>\n";
}
echo $s;
?>
</table>
<?php } ?>
