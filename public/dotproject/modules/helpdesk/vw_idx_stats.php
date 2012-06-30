<?php /* HELPDESK $Id: vw_idx_stats.php,v 1.5 2004/04/29 00:17:47 bloaterpaste Exp $*/
global $m, $ict, $ist;

$stats = array();

foreach ($ict as $k => $v) {
	$sql = "SELECT item_status, count(item_id)
          FROM helpdesk_items
          WHERE item_calltype=$k"
          ." AND ".getPermsWhereClause("companies", "item_company_id").
          "GROUP BY item_status";
	$stats[$k] = db_loadHashList( $sql );
}

?>
<table cellspacing="1" cellpadding="2" border="0" width="100%" class="tbl">
<tr>
	<th colspan="2"><?=$AppUI->_('Status')?>:</th>
<?php
	$s = '';
	foreach ($ist as $k => $v) {
		$s .= "<th width=\"20%\"><a href=\"?m=helpdesk&a=list&item_status=$k\" class=\"hdr\">$v</a></th>";
	}
	echo $s;

	$s = '';
	foreach ($ict as $kct => $vct) {
		$s .= '<tr>';
		$s .= '<td width="15">'
        . dPshowImage (dPfindImage( 'ct'.$kct.'.png', $m ), 15, 17, $ict[$kct])
        . '</td>';
		$s .= "<td nowrap><a href=\"?m=helpdesk&a=list&item_calltype=$kct\">$vct</a></td>";

		foreach ($ist as $kst => $vst) {
			$s .= "<td align=\"center\"><a href=\"?m=helpdesk&a=list&item_calltype={$kct}&item_status=$kst\">"
          . @$stats[$kct][$kst]
          . "</a></td>";
		}

		$s .= '</tr>';
	}
	echo $s;
?>
</table>
