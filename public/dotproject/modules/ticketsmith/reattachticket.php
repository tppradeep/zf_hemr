<?php
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

//update task
$newparent = dPgetParam($_GET, 'newparent', 0);
$ticket = dPgetParam($_GET, 'ticket', 0);
$dbprefix = dPgetConfig('dbprefix','');

$sql1 = "update {$dbprefix}tickets set parent = $newparent,
  assignment = 9999,
  type = 'Client Followup'
  where ticket = $ticket";

header("Location: index.php?m=ticketsmith");
if (isset($newparent) && isset($ticket) && $newparent != 0 && $ticket != 0) {
  // error_log("Updating ticket - $sql1");
  mysql_query($sql1);
  // error_log(mysql_error());
  $sql2 = "update {$dbprefix}tickets set activity = '" . time() . "' where ticket = $newparent";
  // error_log($sql2);
  mysql_query($sql2);
  // error_log($mysql_error());
}
// else error_log("Ticket has not been reassigned");
?>
