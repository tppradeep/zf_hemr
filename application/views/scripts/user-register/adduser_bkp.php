<?php
//$this->title="New Customer Add";
//$this->headTitle($this->title); // for title

?>
 <script language="javascript" type="text/javascript">
    jQuery(document).ready(function(){
                // binds form submission and fields to the validation engine
                jQuery("#userregister").validationEngine();
            });
  </script>
<div class="main-title">
Selected Plan : <?php echo $this->escape($this->sp_view['hp_name']);?>
</div>


<?php 
//$this->Pre($this->formdata);
if($this->formdata['error']!="")
{
	echo '<table width="100%" border="0" cellspacing="0" cellpadding="0">';
	  echo '<tr>';
	    echo '<td><img src="'.$this->baseUrl().'/images/error.png" width="24" height="24" alt="Error" /></td>';

	    if($this->formdata['error']=="facility")
	    	echo '<td class="error">The facility Identifier name ('. $this->formdata['hf_facility_identifier'].') is alreay taken by another user. Please change the facility name</td>';
	    if($this->formdata['error']=="dashboarduser")
	    	echo '<td class="error">The Dashboard User Name ('. $this->formdata['dashboard_userid'].') is alreay taken by another user. Please change username</td>';
	  echo '</tr>';
	echo '</table>';
}
?>
<div class="clear"></div>
<form id="userregister" method="post" action="">
<input name="PlanCustomFields" value='<?php echo $this->Ecode($this->PlanCustomFields);?>' type="hidden">

<table width="95%" border="0" cellspacing="2" cellpadding="0" align="right" id="userregister">
	<tr>
		<td class="form-label-main">Facility Identifier<?php $this->DisplayHelp('UserRegistrtion','FacilityIdentifier');?>
		 </td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2"><input name="hf_facility_identifier" type="text" id="hf_facility_identifier" size="60" maxlength="150" class="validate[required],custom[onlyLetterNumber]" value="<?php echo $this->formdata['hf_facility_identifier']?>" tabindex="1"/></td>
	</tr>
	<tr>
		<td class="form-label-main">&nbsp;</td>
		<td class="form-label-main">&nbsp;</td>
	</tr>
	<tr>
		<td class="form-label-main">Name <?php $this->DisplayHelp('UserRegistrtion','name');?></td>
		<td class="form-label-main">Speciality <?php $this->DisplayHelp('UserRegistrtion','Speciality');?>
		</td>
	</tr>
	<tr>
		<td><input name="hf_facility_name" type="text" id="hf_facility_name" value="<?php echo $this->formdata['hf_facility_name']?>" size="50" maxlength="150" class="validate[required]" tabindex="2"/></td>
		<td><input name="hf_speciality" type="text" id="hf_speciality" value="<?php echo $this->formdata['hf_speciality']?>" size="50" maxlength="150" class="validate[required]" tabindex="3"/></td>
	</tr>
	<tr>
		<td class="form-label-main">&nbsp;</td>
		<td class="form-label-main">&nbsp;</td>
	</tr>
	<tr>
		<td class="form-label-main">
		Dashboard User Id<?php $this->DisplayHelp('UserRegistrtion','DashboardUserId');?></td>
		<td class="form-label-main">Dashboard Password<?php $this->DisplayHelp('UserRegistrtion','Dashboardpassword');?></td>
	</tr>
	<tr>
		<td><input name="dashboard_userid" type="text" id="dashboard_userid" value="<?php echo $this->formdata['dashboard_userid']?>" size="50" maxlength="50" class="validate[required],custom[onlyLetterNumber]" tabindex="4"/></td>
		<td><input name="dashboard_password" type="password" id="dashboard_password" size="25" maxlength="25" class="validate[required],custom[onlyLetterNumber]" tabindex="5"/></td>
	</tr>
	<tr>
		<td class="form-label-main">&nbsp;</td>
		<td class="form-label-main">&nbsp;</td>
	</tr>
	<tr>
		<td class="form-label-main">Confirm Dashboard Password<?php $this->DisplayHelp('UserRegistrtion','ConfirmDashboardPassword ');?>  </td>
		<td class="form-label-main">Email Address <?php $this->DisplayHelp('UserRegistrtion','EmailAddress ');?></td>
	</tr>
	<tr>
		<td><input name="dashboard_password_confirm" type="password" id="dashboard_password_confirm" size="25" maxlength="25" class="validate[required],custom[onlyLetterNumber]" tabindex="6"/></td>
		<td><input name="hf_email" type="text" id="hf_email" value="<?php echo $this->formdata['hf_email']?>" size="50" maxlength="125" class="validate[required],custom[email]" tabindex="7"/></td>
	</tr>
	<tr>
		<td class="form-label-main">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="form-label-main">Address<?php $this->DisplayHelp('UserRegistrtion','StreetAddress');?></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2"><input name="hf_address" value="<?php echo $this->formdata['hf_address']?>" type="text" id="hf_address" size="105" maxlength="250" class="validate[required]" tabindex="8"/>
			<br />
		<span class="form-label-sub">Street Address</span></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="hf_city" type="text" id="hf_city" value="<?php echo $this->formdata['hf_city']?>" size="50" maxlength="150" class="validate[required]" tabindex="9"/>
			<br />
		<span class="form-label-sub">City</span></td>
		<td><input name="hf_state" type="text" id="hf_state" value="<?php echo $this->formdata['hf_state']?>" size="50" maxlength="150" class="validate[required]" tabindex="10"/>
			<br />
		<span class="form-label-sub">State / Province / Region</span></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="hf_zip" type="text" id="hf_zip" value="<?php echo $this->formdata['hf_zip']?>" size="50" maxlength="150" class="validate[required]" tabindex="11"/>
			<br />
		<span class="form-label-sub">Postal / Zip Code</span></td>
		<td>
		<select name="hf_country" id="hf_country"  class="validate[required]" tabindex="12">
		  <?php 
		  $selcountry=$this->formdata['hf_country'];
		  if($selcountry=="")
		  	$selcountry="USA";
		  foreach($this->country as $country)
		  {
		  	
		  	
		  	if($selcountry==$country['Code'])
		  	{
		  		$selval = " selected";
		  	}
		  	else
		  	{
		  		$selval ="";
		  	}
		  	echo "<option value='".$country['Code']."' ".$selval.">".$country['Name']."</option>";
		   
		  }
		  ?>
		</select>
			<br />
		<span class="form-label-sub">Country</span></td>
	</tr>
	<tr>
		<td class="form-label-main">&nbsp;</td>
		<td class="form-label-main">&nbsp;</td>
	</tr>
	<tr>
		<td class="form-label-main">Phone Number<?php $this->DisplayHelp('UserRegistrtion','PhoneNumber');?></td>
		<td class="form-label-main">Fax<?php $this->DisplayHelp('UserRegistrtion','Fax');?></td>
	</tr>
	<tr>
		<td><input name="hf_phone" type="text" id="hf_phone" value="<?php echo $this->formdata['hf_phone']?>" size="10" maxlength="15" class="validate[required]" tabindex="13"/></td>
		<td><input name="hf_fax" type="text" id="hf_fax" value="<?php echo $this->formdata['hf_fax']?>" size="10" maxlength="15" class="validate[required]" tabindex="14"/></td>
	</tr>
	<tr>
		<td class="form-label-main">&nbsp;</td>
		<td class="form-label-main">&nbsp;</td>
	</tr>
	<tr>
		<td class="form-label-main">Tax ID<?php $this->DisplayHelp('UserRegistrtion','TaxID');?></td>
		<td class="form-label-main">NPI<?php $this->DisplayHelp('UserRegistrtion','NPI');?></td>
	</tr>
	<tr>
		<td><input name="hf_tax_id" type="text" id="hf_tax_id" value="<?php echo $this->formdata['hf_tax_id']?>" size="20" maxlength="150" class="validate[required]" tabindex="15"/></td>
		<td><input name="hf_npi" type="text" id="hf_npi" value="<?php echo $this->formdata['hf_npi']?>" size="25" maxlength="150" class="validate[required]" tabindex="16"/></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" name="Submit" value="Register Details" class="user-submit" tabindex="17" /></td>
	</tr>
</table>
</form>
<p>&nbsp;</p>
