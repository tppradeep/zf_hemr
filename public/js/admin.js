// JavaScript Document
function listusers(ival)
{
	$.ajax(
	{
  		url: 'reseller-users-list/cusid/'+ival,
  		success: function(data) 
		{
    		$('#userlist').html(data);
  		}
	});	
	$.ajax(
	{
  		url: 'reseller-role-list/cusid/'+ival,
  		success: function(data) 
		{
    		$('#roleslist').html(data);
  		}
	});	
}
function listroles(ival)
{
//	window.location.href="reseller-role-list/cusid/"+ival;
	
}
function resourcelist(id,cusid,ival,sec)
{
	if(document.getElementById("userid").value==0)
	{
		document.getElementById("controllerlist").innerHTML="";
		document.getElementById("actionlist").innerHTML="";
		alert("Please Select User");
		return false;
	}
	if(ival==true)
	{
		$.ajax(
		{
			url: 'reseller-resource-list/id/'+id+'/cusid/'+ival+'/sec/'+sec,
			success: function(data) 
			{
				$('#controllerlist').html(data);
			}
		});	
	}
}
function actionlist(controller,ival,sec)
{
	var control_values="";
	  $("input:checkbox[name=cont]:checked").each(function() {
		if(control_values!="")
		{
			control_values = control_values +",";
		}
		   control_values = control_values +$(this).val();
	  });
	
//	alert(control_values);
		$.ajax(
		{
			url: 'reseller-action-list/id/'+control_values+'/sec/'+sec,
			success: function(data) 
			{
				$('#actionlist').html(data);
			}
		});	
}

// Group Section
function listusersGroup(ival)
{
	$.ajax(
	{
  		url: 'reseller-users-list/cusid/'+ival,
  		success: function(data) 
		{
    		$('#userlist').html(data);
  		}
	});	
	$.ajax(
	{
  		url: 'reseller-role-list/cusid/'+ival+'/sec/group',
  		success: function(data) 
		{
    		$('#rolelisting').html(data);
  		}
	});	
}

function resourcelistgroup(cusid)
{
	$.ajax(
	{
		url: 'reseller-resource-list/sec/group/cusid/'+cusid,
		success: function(data) 
		{
			$('#controllerlist').html(data);
		}
	});	
}
function userprivilage(resid,hf_id)
{
	var control_values="";
	  $("input:checkbox[name=cont]:checked").each(function() {
		if(control_values!="")
		{
			control_values = control_values +",";
		}
		   control_values = control_values +$(this).val();
	  });
		$.ajax(
		{
			url: '../../user-action-list/id/'+control_values+'/hf_id/'+hf_id+'',
			success: function(data) 
			{
				$('#privilegelist').html(data);
			}
		});	
}
function useraction(actionid,hf_id)
{
		var control_values="";
	  $("input:checkbox[name=act]:checked").each(function() {
		if(control_values!="")
		{
			control_values = control_values +",";
		}
		   control_values = control_values +$(this).val();
	  });
	//  alert(control_values);
		$.ajax(
		{
			url: '../../set-permission/id/'+control_values+'/hf_id/'+hf_id+'',
			success: function(data) 
			{
				//$('#privilegelist').html(data);
			}
		});	
}