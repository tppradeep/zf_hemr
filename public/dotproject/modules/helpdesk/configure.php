<?php /* HELPDESK $Id: configure.php,v 1.2 2004/05/06 20:07:06 agorski Exp $ */
$AppUI->savePlace();

if (isset($_POST['update'])) {
  // Processing
}

$titleBlock = new CTitleBlock( 'Help Desk Configuration', 'helpdesk.png', $m, "$m.$a");
$titleBlock->addCrumb( "?m=helpdesk", "Home" );
$titleBlock->addCrumb( "?m=helpdesk&a=configure", "Configure" );
$titleBlock->show();
?>

<table class="std">
<form method="post" action="<?=$_SERVER['PHP_SELF']?>">
  <tr>
    <td>Some question?</td>
    <td><input type="radio" name="someinput" id="some_yes" value="1">
        <label for="some_yes">Yes</label>
        <input type="radio" name="someinput" id="some_no" value="0">
        <label for="some_no">No</label>
    </td>
  </tr>
  <tr>
    <td colspan="2"><input type="submit" name="update" value="Update"></td>
  </tr>
</form>
</table>
